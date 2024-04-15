module "vpc" {
  source = "git::https://github.com/MMR-46org/tf-module-vpc.git"
  for_each       = var.vpc


  vpc_cidr     =   each.value["vpc_cidr"]
  public_subnets_cidr   = each.value["public_subnets_cidr"]
  web_subnets_cidr     = each.value["web_subnets_cidr"]
  app_subnets_cidr     =  each.value["app_subnets_cidr"]
  db_subnets_cidr        =  each.value["db_subnets_cidr"]
  env                    = var.env
  project_name           =  var.project_name
  az                     =  each.value ["az"]
}


