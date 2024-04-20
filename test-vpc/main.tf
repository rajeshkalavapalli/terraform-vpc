module "ROBOSHOP" {
  source = "../aws-vpc"
  enable_dns_hostnames = var.enable_dns_hostnames
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  vpc_tags = var.vpc_tags

  # public subnets
  public_subnets_cidr = var.public_subnets_cidr
  #private subnets
  private_subnets_cidr = var.private_subnets_cidr

  #database 
  database_subnets_cidr = var.database_subnets_cidr
  #is peering require
  is_peering_required = var.is_peering_required

 
}