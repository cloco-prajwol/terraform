provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  prefix   = "${var.environment_short_name}-${var.project_name}"
  web_fqdn = var.web_fqdn
}
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.environment_short_name}-${var.project_name}-np-clc"
  }
}

module "public_subnet" {
  source             = "./modules/public_subnet"
  vpc                = aws_vpc.main.id
  prefix             = local.prefix
  vpc_cidr           = aws_vpc.main.cidr_block
  availability_zones = var.availability_zones
}

module "private_subnet" {
  source             = "./modules/private_subnet"
  vpc                = aws_vpc.main.id
  prefix             = local.prefix
  vpc_cidr           = aws_vpc.main.cidr_block
  availability_zones = var.availability_zones
}

# module "bastion_server" {
#   source = "./modules/bastion"
# }
