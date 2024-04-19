variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
  default = {}
}

variable "vpc_tags" {
    default = {}
  
}

variable "project_name" {
    type = string
    default = "ROBOSHOP"
  
}

variable "environment" {
  default = "dev"
}

variable "enable_dns_hostnames" {
    type = bool
    default = "true"
  
}

variable "igw_tags" {
  default = {}
}