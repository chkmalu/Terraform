variable "sub-name" {
  description = "name of the subnet"
  
}

variable "cidr-block" {
    description = "cidr block for vpc & subnet"
    type = list(string)
  
}

variable "tag-name" {
    description = "resource name"
    type = map(string)
  
}