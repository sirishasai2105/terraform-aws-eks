module "mysql_security_group" {
    source =  "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    # sg_tags = "mysql"
    sg_tags = var.mysqll_sg_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "node_security_group" {
    source =  "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    # sg_tags = "mysql"
    sg_tags = var.node_sg_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "eks_control_plane_security_group" {
    source =  "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    # sg_tags = "mysql"
    sg_tags = var.eks_sg_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "ingress_controller_security_group" {
    source =  "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    # sg_tags = "mysql"
    sg_tags = var.ingress_sg_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}



module "bastion_security_group" {
    source =  "../../terraform-aws-security-group"
    project_name = var.project_name
    environment = var.environment
    # sg_tags = "mysql"
    sg_tags = var.bastion_sg_tags
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}


#bastion accepting from mysql
resource "aws_security_group_rule" "bastion_from_mysql" {
  type = "ingress"
  security_group_id = module.mysql_security_group.sg_id
  from_port         = 22
  protocol       = "tcp"
  to_port           = 22
  source_security_group_id = module.bastion_security_group.sg_id 
  
}




#bastion accepting from public
resource "aws_security_group_rule" "bastion_from_public" {
  type = "ingress"
  security_group_id = module.bastion_security_group.sg_id
  from_port         = 22
  protocol       = "tcp"
  to_port           = 22
  cidr_blocks = ["0.0.0.0/0"]
  
}

#ingress load balancer accepting connections from public
resource "aws_security_group_rule" "ingress_from_public_https" {
  type = "ingress"
  security_group_id = module.ingress_controller_security_group.sg_id
  from_port         = 443
  protocol       = "tcp"
  to_port           = 443
  cidr_blocks = ["0.0.0.0/0"]
}

#nodes accepting connections from ingress
resource "aws_security_group_rule" "node_ingress_alb" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  source_security_group_id = module.ingress_controller_security_group.sg_id
  security_group_id = module.node_security_group.sg_id
}

#node accepting connections from eks control plane
resource "aws_security_group_rule" "node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_control_plane_security_group.sg_id
  security_group_id = module.node_security_group.sg_id
}

#eks control plane accepting connections from node
resource "aws_security_group_rule" "eks_control_plane_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.node_security_group.sg_id
  security_group_id = module.eks_control_plane_security_group.sg_id
}

#eks accepting connection from bastion
resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion_security_group.sg_id
  security_group_id = module.eks_control_plane_security_group.sg_id
}

resource "aws_security_group_rule" "node_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = module.node_security_group.sg_id
}

resource "aws_security_group_rule" "node_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion_security_group.sg_id
  security_group_id = module.node_security_group.sg_id
}




