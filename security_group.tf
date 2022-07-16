//bastion sg
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
resource "aws_security_group" "Bastion-instance" {
name = "bastion-host-sg"
vpc_id = module.vpc.vpc_id

ingress {

    cidr_blocks = [
      "0.0.0.0/0"
    ]
from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


//private sg
resource "aws_security_group" "Private-instance" {
name = "Private-Instances-sg"
vpc_id = module.vpc.vpc_id
ingress {
    cidr_blocks = [
      "10.0.0.0/16"
    ]
from_port = 0
    to_port = 65535
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

//public web sg
resource "aws_security_group" "public-sg" {
name = "public-web-sg"
vpc_id = module.vpc.vpc_id
ingress {
    cidr_blocks = [
      "${chomp(data.http.myip.body)}/32"
    ]
from_port = 80
    to_port = 80
    protocol = "tcp"
  }
// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
