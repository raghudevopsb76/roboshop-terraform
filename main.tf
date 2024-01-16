module "vpc" {
  source = "git::https://github.com/raghudevopsb76/tf-module-vpc.git"

  for_each       = var.vpc
  vpc_cidr_block = each.value["vpc_cidr_block"]
  public_subnets = each.value["public_subnets"]
  web_subnets    = each.value["web_subnets"]
  app_subnets    = each.value["app_subnets"]
  db_subnets     = each.value["db_subnets"]
  azs            = each.value["azs"]

  env                    = var.env
  tags                   = var.tags
  default_vpc_cidr       = var.default_vpc_cidr
  default_vpc_id         = var.default_vpc_id
  account_id             = var.account_id
  default_route_table_id = var.default_route_table_id
}

