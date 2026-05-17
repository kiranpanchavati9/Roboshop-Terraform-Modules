module "network" {
  source = "./network"
}

module "ec2" {
  for_each = var.component_name
  source = "./ec2"
  ami =  var.ami
  instance_type =  var.instance_type
  vpc_sg_id = [module.network.sg_id]
  iam_role = var.iam_role
  component_name = each.key
}

module "route53" {
  for_each = var.component_name
  source = "./route53"
  zone_id = var.zone_id
  dns_type = var.dns_type
  ttl = var.ttl
  component_name = each.key
  private_ip = module.ec2.ec2.private_ip
}

module "ansible"{

  for_each = var.component_name

  depends_on = [
    module.route53
  ]

  source = "./Ansible"
  component_name = each.key
  private_ip = module.ec2.ec2.private_ip

}
