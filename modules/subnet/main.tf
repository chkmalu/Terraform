#create subnect for vpc
resource "aws_subnet" "myapp-subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_subnet

  tags = {
    Name = "${var.tag_name}-subnet"
  }
}
#adv default route on the rbt created by vpn by default
resource "aws_default_route_table" "myapp-rtb" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }

  tags = {
    Name = "${var.tag_name}-rtb"
  }
}
#associate subnet created to the rtb
resource "aws_route_table_association" "rtb_a" {
  subnet_id = aws_subnet.myapp-subnet.id
  route_table_id = var.default_route_table_id
}
#create igw for public access
resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}-igw"
  }
}