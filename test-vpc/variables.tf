variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
  default = {
    project_name = "roboshop"
    environment = "dev"
    terraform = "true"
  }
}

variable "vpc_tags" {
    default = {}
  
}

variable "project_name" {
    type = string
    default = "ROBOSHOP"
  
}

variable "environment" {
  default = "DEV"
}

variable "enable_dns_hostnames" {
    type = bool
    default = "true"
  
}

variable "igw_tags" {
  default = {}
}