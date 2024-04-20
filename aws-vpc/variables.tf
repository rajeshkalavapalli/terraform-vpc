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

variable "public_subnets_cidr" {
  type = list 
  validation {
    condition = length(var.public_subnets_cidr) == 2
    error_message = "please give 2 public valid subnets cidr"
  }
}

variable "public_subnets_tags" {
  default = {}
}

variable "private_subnets_cidr" {
  type = list 
  validation {
    condition = length(var.private_subnets_cidr) == 2
    error_message = "please give 2 private valid subnets cidr"   
  }
}

variable "private_subnets_tags" {
  default = {}
}


variable "database_subnets_cidr" {
  type = list 
  validation {
    condition = length(var.database_subnets_cidr) == 2
    error_message = "please give 2 database valid subnets cidr"   
  }
}

variable "database_subnets_tags" {
  default = {}
}

variable "natgatway_tags" {
  default = {}
}

variable "public_route_table_tags" {
  default = {}
}

variable "private_route_table_tags" {
  default = {}
}

variable "database_route_table_tags" {
  default = {}
}


variable "is_peering_required" {
  type = bool
  default = false
}

variable "acceptor_vpc_id" {
    type = string
    default = ""
  
}

variable "vpc_peering_tags" {
  default = {}
}

