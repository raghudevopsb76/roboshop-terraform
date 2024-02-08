env = "dev"
tags = {
  company      = "XYZ Co"
  bu_unit      = "Ecommerce"
  project_name = "roboshop"
}
account_id             = "633788536644"
default_vpc_id         = "vpc-0a8e3e6a0d6cb90d9"
default_route_table_id = "rtb-0b9a867762d6530ba"
default_vpc_cidr       = "172.31.0.0/16"
route53_zone_id        = "Z0021413JFIQEJP9ZO9Z"
kms                    = "arn:aws:kms:us-east-1:633788536644:key/36a1180a-d43b-4561-ab19-dc55e634b8fb"
certificate_arn        = "arn:aws:acm:us-east-1:633788536644:certificate/f48fadb0-e24c-4370-90e8-d3718672a46e"
bastion_cidrs          = ["172.31.37.78/32"]
prometheus_cidrs       = ["172.31.41.244/32"]

vpc = {
  main = {
    vpc_cidr_block = "10.11.0.0/16"
    public_subnets = ["10.11.0.0/24", "10.11.1.0/24"]
    web_subnets    = ["10.11.2.0/24", "10.11.3.0/24"]
    app_subnets    = ["10.11.4.0/24", "10.11.5.0/24"]
    db_subnets     = ["10.11.6.0/24", "10.11.7.0/24"]
    azs            = ["us-east-1a", "us-east-1b"]
  }
}

rds = {
  main = {
    allocated_storage      = 20
    engine                 = "mysql"
    engine_version         = "5.7.44"
    instance_class         = "db.t3.micro"
    parameter_group_family = "mysql5.7"
  }
}

docdb = {
  main = {
    engine                 = "docdb"
    engine_version         = "4.0.0"
    instance_class         = "db.t3.medium"
    parameter_group_family = "docdb4.0"
    instance_count         = 1
  }
}

elasticache = {
  main = {
    engine                 = "redis"
    engine_version         = "6.2"
    node_type              = "cache.t3.micro"
    parameter_group_family = "redis6.x"
    num_cache_nodes        = 1
  }
}

rabbitmq = {
  main = {
    instance_type = "t3.small"
  }
}

app = {
  catalogue = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 1
  }
  frontend = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 80
    app_subnet_name = "web_subnets"
    lb_subnet_name  = "public_subnets"
    alb_name        = "public"
    priority        = 1
  }
  cart = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 2
  }
  user = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 3
  }
  shipping = {
    instance_type   = "t3.medium"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 4
  }
  payment = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 5
  }
  dispatch = {
    instance_type   = "t3.small"
    instance_count  = 1
    app_port        = 8080
    app_subnet_name = "app_subnets"
    lb_subnet_name  = "app_subnets"
    alb_name        = "private"
    priority        = 6
  }
}


alb = {
  public = {
    certificate_arn = "arn:aws:acm:us-east-1:633788536644:certificate/f48fadb0-e24c-4370-90e8-d3718672a46e"
    internal        = false
    sg_cidrs        = ["0.0.0.0/0"]
    subnet_name     = "public_subnets"
  }
  private = {
    certificate_arn = "arn:aws:acm:us-east-1:633788536644:certificate/f48fadb0-e24c-4370-90e8-d3718672a46e"
    internal        = true
    sg_cidrs        = ["10.11.2.0/24", "10.11.3.0/24", "10.11.4.0/24", "10.11.5.0/24"]
    subnet_name     = "app_subnets"
  }
}

eks = {

}