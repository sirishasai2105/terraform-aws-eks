variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "reyanshsai.online"
}

variable "zone_id" {
    default = "Z01089512XQ8J5XJOKNVR"
}