module "vpc" {
  source                    = "./modules/vpc"
  vpc_name                  = "ecs-project-vpc"
  vpc_cidr_block            = "10.0.0.0/16"
  public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_availability_zones = ["eu-west-2a", "eu-west-2b"]
}

module "security_groups" {
  source                  = "./modules/security_groups"
  vpc_id                  = module.vpc.vpc_id
  ecs_security_group_name = "ecs-security-group"
  alb_security_group_name = "alb-security-group"
}


module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnets
  alb_name          = "ecs-project-alb"
  target_group_name = "ecs-project-tg"
  alb_sg_id         = module.security_groups.alb_sg_id
  target_port       = 3000
  cert_arn          = module.route53.ssl_cert_arn
}

module "ecs" {
  source           = "./modules/ecs"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnets
  alb_sg_id        = module.security_groups.alb_sg_id
  ecs_sg_id        = module.security_groups.ecs_sg_id
  cluster_name     = "tc-cluster"
  ecs_task_family  = "tc-task"
  c_cpu            = "2048"
  c_mem            = "4096"
  c_name           = "tc-container"
  c_img            = "${local.ecr_repo}:latest"
  c_port           = 3000
  service_name     = "tc-service"
  desired_num      = 1
  tg_arn           = module.alb.tg_arn
  http_listen_arn  = module.alb.http_listen
  https_listen_arn = module.alb.https_listen
}


module "route53" {
  source         = "./modules/route53"
  root_domain    = local.root_domain
  dns_record_ttl = local.dns_record_ttl
  alb_dns        = module.alb.alb_dns
  alb_zone_id    = module.alb.alb_zone_id
}

