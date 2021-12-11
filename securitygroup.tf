resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allows ssh and http from the internet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "SHH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = " HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_hhtp"
  }
}
