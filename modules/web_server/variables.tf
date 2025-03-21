variable "prefix" {
  type = string
}
variable "vpc" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
   type = string
}

variable "private_subnet" {
   type = string
}

variable "bastion_sg_id" {
   type = string
}