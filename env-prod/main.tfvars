env                         = "prod"
project_name                = "roboshop"
kms_key_id                  = "arn:aws:kms:us-east-1:512646826903:key/91ae5e2e-d734-4d42-b51d-1acf22378265"
bastion_cidrs               = ["172.31.15.146/32"]
prometheus_cidrs            = ["172.31.42.220/32"]
acm_arn                     = "arn:aws:acm:us-east-1:512646826903:certificate/dc09d2e1-e117-481f-ade8-aad6b14f165d"
zone_id                     = "Z0189341LG4L24HIU4QF"



vpc  = {
  main = {
    vpc_cidr                =  "10.20.0.0/21"
    public_subnets_cidr     =  ["10.20.0.0/25", "10.20.0.128/25"]
    web_subnets_cidr        =  ["10.20.1.0/25", "10.20.1.128/25"]
    app_subnets_cidr        =  ["10.20.2.0/25", "10.20.2.128/25"]
    db_subnets_cidr         =  ["10.20.3.0/25", "10.20.3.128/25"]
    az                      =   ["us-east-1a", "us-east-1b"]

  }
}



rds = {
  main = {
    allocated_storage      = 20
    engine                 = "mysql"
    engine_version         = "5.7.44"
    instance_class         = "db.m5.large"
    parameter_group_family = "mysql5.7"
  }

}


app = {
  main  = {
    backend_app_port          = 8080
    backend_instance_capacity = 2
    backend_instance_type     = "t3.small"


    frontend_app_port       = 80
    frontend_instance_capacity = 2
    frontend_instance_type    = "t3.small"


  }
}

alb = {
  main = {
    alb_name               =  "public"
    internal               =  false
    sg_cidr_blocks         = ["0.0.0.0/0"]


    private_alb_name       =  "private"
    private_internal       =  true

  }
}


eks = {
  main = {
    node_groups = {
      n2 = {
        size           = 1
        instance_types = ["m7i.large"]
        capacity_type  = "SPOT"
      }
    }
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