variable "aws_region" {
  default = "ap-south-1"
}

variable "aws_profile" {
  default = "clc-np-prajwol-shakya"
}

variable "environment_short_name" {
  default = "dev"

}

variable "project_name" {
  default = "ec-orange-clc-terraform"
}

variable "web_fqdn" {
  default = "terraform.test"
}

variable "availability_zones" {
  default = "aps1-az1"
}

variable "public_ssh_key" {
  description = "The SSH key pair"
  type        = string
  default     = ""
}

variable "ami" {
  default = "ami-00bb6a80f01f03502"
}

variable "instance_type" {
  default = "t2.micro"
}