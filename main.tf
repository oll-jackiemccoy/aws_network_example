module "networking" {
  source = "./networking"
}
module "route53" {
  source = "./route53"

  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
}
module "ec2" {
  source = "./ec2"

}