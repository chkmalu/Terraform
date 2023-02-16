provider "aws" {}

resource "aws_vpc" "test-vpc" {
  cidr_block = var.cidr-block[0]
  tags = {
    Name = var.tag-name["vpc-name"]
  }
}

data "aws_vpc" "data-test" {
  id = aws_vpc.test-vpc.id
}

resource "aws_subnet" "test-subnet" {
  vpc_id = data.aws_vpc.data-test.id
  cidr_block = var.cidr-block[1]

  tags = {
    Name = var.tag-name["subnet-name"]
  }
}

output "test_vpc_id" {
  value = aws_vpc.test-vpc.id
  
}