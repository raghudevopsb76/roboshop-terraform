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


module "rds" {
  source = "git::https://github.com/raghudevopsb76/tf-module-rds.git"

  for_each               = var.rds
  rds_allocated_storage  = each.value["rds_allocated_storage"]
  rds_engine             = each.value["rds_engine"]
  rds_engine_version     = each.value["rds_engine_version"]
  rds_instance_class     = each.value["rds_instance_class"]
  parameter_group_family = each.value["parameter_group_family"]

  env  = var.env
  tags = var.tags
  kms  = var.kms

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "db_subnets", null)

}


module "docdb" {
  source = "git::https://github.com/raghudevopsb76/tf-module-docdb.git"

  for_each               = var.docdb
  instance_count         = each.value["instance_count"]
  engine                 = each.value["engine"]
  engine_version         = each.value["engine_version"]
  instance_class         = each.value["instance_class"]
  parameter_group_family = each.value["parameter_group_family"]

  env  = var.env
  tags = var.tags
  kms  = var.kms

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "db_subnets", null)

}
