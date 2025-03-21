resource "aws_security_group" "sg" {
  name        = "${var.prefix}-bastion-sg"
  description = "security group to allow inbound/outbound from the VPC"
  vpc_id      = var.vpc
  tags = {
    Nmae = "${var.prefix}-bastion-sg"
  }
}
resource "aws_security_group_rule" "sgr" {
  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_network_interface" "bastion_ni" {
  subnet_id = var.pub_subnet

  security_groups = [
    aws_security_group.sg.id
  ]

  tags = {
    Name = "${var.prefix}-ni-bastion"
  }
}


resource "aws_instance" "bastion" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 8
    volume_type = "gp3"
  }
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.bastion_ni.id
  }

  tags = {
    Name = "${var.prefix}-bastion"
  }
}
