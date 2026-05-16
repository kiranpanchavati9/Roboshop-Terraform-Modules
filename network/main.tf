resource "aws_security_group" "main" {
  name        = "roboshop-allow-all-traffic"
  description = "Allow TLS inbound traffic and all outbound traffic"
  #vpc_id      = aws_vpc.main.id

  tags = {
    Name = "roboshop-allow-all-traffic"
  }
}