module "vpc" {
  source = "./module"
  AWS_ACCESS_KEY = "${var.AWS_ACCESS_KEY}"
  AWS_SECRET_KEY = "${var.AWS_SECRET_KEY}"
  AWS_REGION = "ap-south-1"
}

resource "aws_instance" "example" {
 subnet_id = module.vpc.subnet_id
 ami = "${var.AMI}"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${aws_security_group.allow_ssh_http.id}"]
}

output "ip" {
   value = "${aws_instance.example.public_ip}"
}
