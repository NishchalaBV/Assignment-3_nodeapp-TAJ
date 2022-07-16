//BASTION EC2
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "NishKey2085per"

  vpc_security_group_ids = [aws_security_group.Bastion-instance.id]
  subnet_id = module.vpc.public_subnets[0]
 tags = {
    Name = "Bastion-assignment"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.bastion.id
  vpc      = true
}


//APP EC2
data "aws_ami" "ubuntu1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu1.id
  instance_type = "t2.medium"
  key_name      = "NishKey2085per"
  vpc_security_group_ids = [aws_security_group.Private-instance.id]
  subnet_id = module.vpc.private_subnets[1]
 tags = {
    Name = "AppServer-assignment"
  }
}



//JENKINS EC2
data "aws_ami" "ubuntu3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu3.id
  instance_type = "t2.medium"
  key_name      = "NishKey2085per"
  vpc_security_group_ids = [aws_security_group.Private-instance.id]
  subnet_id = module.vpc.private_subnets[0]
 tags = {
    Name = "JenkinsEC2-assignment"
  }
}
