module "networking" {
  source = "./networking"
}
module "route53" {
  source = "./route53"

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
}
module "compute" {
  source = "./compute"

  vpc_id              = module.networking.vpc_id
  private_subnet_ids  = module.networking.private_subnet_ids
  private_subnet_id_a = module.networking.private_subnet_id_a
  private_subnet_id_b = module.networking.private_subnet_id_b

}