module "vpc" {
  source = "git::https://github.com/MMR-46org/tf-module-vpc.git"
  for_each       = var.vpc


  vpc_cidr     =   each.value["vpc_cidr"]
  public_subnets_cidr   = each.value["public_subnets_cidr"]
  web_subnets_cidr     = each.value["web_subnets_cidr"]
  app_subnets_cidr     =  each.value["app_subnets_cidr"]
  db_subnets_cidr        =  each.value["db_subnets_cidr"]
  az                     =  each.value ["az"]

  env                    = var.env
  project_name           =  var.project_name
}




module "eks" {
  source = "git::https://github.com/MMR-46org/tf-module-eks.git"
  for_each       = var.eks

  env                    = var.env
  project_name           =  var.project_name
  component              =  "eks"

  subnet_ids             = lookup(lookup(module.vpc, "main" , null), "app_subnet_ids", null)
  node_groups            = each.value["node_groups"]
}




module "docdb" {
  source                = "git::https://github.com/MMR-46org/tf-module-docdb.git"
  for_each              = var.docdb

  tags                  = {}
  env                   = var.env
  kms                   = var.kms_key_id
  project_name          =  var.project_name


  engine                =  each.value["engine"]
  engine_version        =  each.value["engine_version"]
  instance_class        =  each.value["instance_class"]
  parameter_group_family= each.value["parameter_group_family"]
  instance_count        = each.value["instance_count"]

  subnets               = lookup(lookup(module.vpc, "main", null), "db_subnet_ids" , null )
  vpc_id                = lookup(lookup(module.vpc, "main" , null), "vpc_id", null)
  sg_cidrs              = lookup(lookup(var.vpc, "main", null), "app_subnets_cidr", null)


 }




module "elasticache" {
  source                = "git::https://github.com/MMR-46org/tf-module-elasticache.git"
  for_each              = var.elasticache

  env                   = var.env
  tags                  = {}
  kms                   = var.kms_key_id
  project_name          = var.project_name


  num_cache_nodes       = each.value["num_cache_nodes"]
  engine                = each.value["engine"]
  engine_version        = each.value["engine_version"]
  node_type             = each.value["node_type"]
  parameter_group_family= each.value["parameter_group_family"]


  subnets               = lookup(lookup(module.vpc, "main", null), "db_subnet_ids" , null)
  vpc_id                = lookup(lookup(module.vpc, "main", null), "vpc_id" , null)
  sg_cidrs              = lookup(lookup(var.vpc, "main", null), "app_subnets_cidr", null)


}



module "rds" {
  source                 = "git::https://github.com/MMR-46org/tf-module-rds.git"
  for_each               = var.rds

  env                    = var.env
  tags                   = {}
  kms                    = var.kms_key_id
  project_name           =  var.project_name

  allocated_storage      = each.value["allocated_storage"]
  engine                 = each.value["engine"]
  engine_version         = each.value["engine_version"]
  parameter_group_family = each.value["parameter_group_family"]
  instance_class         = each.value["instance_class"]

  subnets              = lookup(lookup(module.vpc, "main", null), "db_subnet_ids", null)
  vpc_id               = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs             = lookup(lookup(var.vpc, "main", null), "app_subnets_cidr", null)

}


module  "rabbitmq" {
  source               = "git::https://github.com/MMR-46org/tf-module-rabbitmq.git"
  for_each             = var.rabbitmq

  instance_type = each.value["instance_type"]
  env             = var.env
  tags            = {}
  kms             = var.kms_key_id
  bastion_cidrs   = var.bastion_cidrs
  route53_zone_id = var.zone_id
  project_name    = var.project_name

  subnets  = lookup(lookup(module.vpc, "main", null), "db_subnets_ids", null)
  vpc_id   = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_cidrs = lookup(lookup(var.vpc, "main", null), "app_subnets_cidr", null)


}