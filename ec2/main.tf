resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_sg_id
  iam_instance_profile   = var.iam_role
  key_name = "roboshop-dev"

  tags = {
    Name        =  var.component_name
  }
}