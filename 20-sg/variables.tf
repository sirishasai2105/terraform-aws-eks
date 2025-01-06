variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev" 
}

variable "mysqll_sg_tags" {
    default = "mysqll_sg"
}

variable "node_sg_tags" {
default = "node_sg"
}

variable "eks_sg_tags" {
    default = "eks_sg"
}

variable "bastion_sg_tags" {
    default = "bastion_sg"
}

variable "ingress_sg_tags" {
    default = "ingress_sg"
}

variable "app_lb_tags" {
    default = "app-lb"
}

variable "vpn_tags" {
    default = "vpn"
}

variable "web_lb_tags" {
    default = "web-lb"
}







