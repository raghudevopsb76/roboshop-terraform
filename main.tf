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
  allocated_storage      = each.value["allocated_storage"]
  engine                 = each.value["engine"]
  engine_version         = each.value["engine_version"]
  instance_class         = each.value["instance_class"]
  parameter_group_family = each.value["parameter_group_family"]

  env  = var.env
  tags = var.tags
  kms  = var.kms

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "app_subnets", null)

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
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "app_subnets", null)

}

module "elasticache" {
  source = "git::https://github.com/raghudevopsb76/tf-module-elasticache.git"

  for_each               = var.elasticache
  num_cache_nodes        = each.value["num_cache_nodes"]
  engine                 = each.value["engine"]
  engine_version         = each.value["engine_version"]
  node_type              = each.value["node_type"]
  parameter_group_family = each.value["parameter_group_family"]

  env  = var.env
  tags = var.tags
  kms  = var.kms

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "app_subnets", null)

}

module "rabbitmq" {
  source = "git::https://github.com/raghudevopsb76/tf-module-rabbitmq.git"

  for_each      = var.rabbitmq
  instance_type = each.value["instance_type"]

  env             = var.env
  tags            = var.tags
  kms             = var.kms
  bastion_cidrs   = var.bastion_cidrs
  route53_zone_id = var.route53_zone_id

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "app_subnets", null)

}

module "app" {
  source = "git::https://github.com/raghudevopsb76/tf-module-app.git"

  for_each       = var.app
  component      = each.key
  instance_type  = each.value["instance_type"]
  instance_count = each.value["instance_count"]
  app_port       = each.value["app_port"]

  env              = var.env
  tags             = var.tags
  kms              = var.kms
  bastion_cidrs    = var.bastion_cidrs
  prometheus_cidrs = var.prometheus_cidrs

  subnets  = lookup(lookup(module.vpc, "main", null), each.value["app_subnet_name"], null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), each.value["lb_subnet_name"], null)

}

module "alb" {
  source = "git::https://github.com/raghudevopsb76/tf-module-alb.git"

  for_each        = var.alb
  certificate_arn = each.value["certificate_arn"]
  enable_https    = each.value["enable_https"]
  ingress_ports   = each.value["ingress_ports"]
  internal        = each.value["internal"]

  type = each.key

  env             = var.env
  route53_zone_id = var.route53_zone_id
  tags            = var.tags

  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  subnets  = lookup(lookup(module.vpc, "main", null), each.value["subnet_name"], null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), each.value["sg_cidrs"], null)
}