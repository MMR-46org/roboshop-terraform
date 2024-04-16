env                         = "dev"
project_name                = "expense"
kms_key_id                  = "arn:aws:kms:us-east-1:512646826903:key/91ae5e2e-d734-4d42-b51d-1acf22378265"
bastion_cidrs               = ["172.31.15.146/32"]
prometheus_cidrs            = ["172.31.42.220/32"]
acm_arn                     = "arn:aws:acm:us-east-1:512646826903:certificate/dc09d2e1-e117-481f-ade8-aad6b14f165d"
zone_id                     = "Z0189341LG4L24HIU4QF"



vpc  = {
  main = {
    vpc_cidr                =  "10.10.0.0/21"
    public_subnets_cidr     =  ["10.10.0.0/25", "10.10.0.128/25"]
    web_subnets_cidr        =  ["10.10.1.0/25", "10.10.1.128/25"]
    app_subnets_cidr        =  ["10.10.2.0/25", "10.10.2.128/25"]
    db_subnets_cidr         =  ["10.10.3.0/25", "10.10.3.128/25"]
    az                      =   ["us-east-1a", "us-east-1b"]

  }
}



eks  = {
  main = {
    node_groups = {
      n1 = {
        size   = 1
        instance_types = ["t3.large"]
        capacity_type  = "SPOT"

      }
    }
  }
}
