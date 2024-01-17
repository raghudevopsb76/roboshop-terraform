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
    rds_allocated_storage  = 20
    rds_engine             = "mysql"
    rds_engine_version     = "5.7.44"
    rds_instance_class     = "db.t3.micro"
    parameter_group_family = "mysql5.7"
  }
}

