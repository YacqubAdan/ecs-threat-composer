variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}

variable "subnet_availability_zones" {
  description = "The availability zones for the private subnet"
  type        = list(string)
}

variable "vpc_name" {
  description = "The name tag for the VPC"
  type        = string
  default     = "WordPressVPC"
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
  default     = "PublicSubnet"
}

variable "internet_gateway_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "InternetGateway"
}

variable "route_table_name" {
  description = "The name of the the route table"
  type        = string
  default     = "RouteTable"
}




