module "network" {
  source = "./network"
}

module "ec2" {
  source = "./ec2"
  ami =  var.ami
  instance_type =  var.instance_type
  vpc_sg_id = [module.network.sg_id]
  iam_role = var.iam_role
  component_name = var.component_name
}

module "route53" {
  source = "./route53"
  zone_id = var.zone_id
  dns_type = var.dns_type
  ttl = var.ttl
  component_name = var.component_name
  private_ip = module.ec2.ec2.private_ip
}
