output "ec2" {
  value = {
    private_ip = aws_instance.main.private_ip
  }
}