provider "aws" {}

#create vpc 
resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "${var.tag_name}-vpc"
  }
}

module "subnet_mod" {
  source = "./modules/subnet"
  cidr_subnet = var.cidr_subnet
  tag_name = var.tag_name
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "webserver_mod" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp-vpc.id
  tag_name = var.tag_name
  subnet_id = module.subnet_mod.subnet_blk.id
  key_path = var.key_path
  image_name = var.image_name
}

output "pub_ip" {
  value = module.webserver_mod.pub_ip
  
}