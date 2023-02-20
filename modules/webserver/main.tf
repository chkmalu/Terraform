#create SG
resource "aws_default_security_group" "dev-sg" {
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "app-traffic"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-sg"
  }
}
#create Ec2 instance
data "aws_ami" "amazon_image" {
  most_recent = true

  filter {
    name = "name"
    values = [var.image_name]
  }
  owners = ["amazon"]
}

resource "aws_instance" "TF-server" {
  ami = data.aws_ami.amazon_image.id
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
  security_groups = [aws_default_security_group.dev-sg.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.dev_kp.key_name
  root_block_device {
    volume_type = "gp2"
  volume_size = "20"
  }
  user_data = file("deployment_script.sh")
  tags = {
    Name = "${var.tag_name}-instance"
  }
}

resource "aws_key_pair" "dev_kp" {
  key_name = "dev_kp"
  public_key = file(var.key_path)
}