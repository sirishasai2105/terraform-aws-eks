resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion_security_group.sg_id
  # lifecycle {
  #   prevent_destroy = true  # Prevents accidental deletion
  # }
}

resource "aws_ssm_parameter" "mysql_sg_ids" {
  name  = "/${var.project_name}/${var.environment}/mysql_sg_ids"
  type  = "String"
  value = module.mysql_security_group.sg_id

}

resource "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name  = "/${var.project_name}/${var.environment}/eks_control_plane_sg_id"
  type  = "String"
  value = module.eks_control_plane_security_group.sg_id

}

resource "aws_ssm_parameter" "node_sg_id" {
  name  = "/${var.project_name}/${var.environment}/node_sg_id"
  type  = "String"
  value = module.node_security_group.sg_id

}

resource "aws_ssm_parameter" "ingress_sg_id" {
  name  = "/${var.project_name}/${var.environment}/ingress_sg_id"
  type  = "String"
  value = module.ingress_controller_security_group.sg_id

}
