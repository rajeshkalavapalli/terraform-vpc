module "ROBOSHOP" {
  source = "../aws-vpc"
  enable_dns_hostnames = var.enable_dns_hostnames
  project_name = var.project_name
  environment = var.environment
  common_tags = var.common_tags
  vpc_tags = var.vpc_tags
  
}