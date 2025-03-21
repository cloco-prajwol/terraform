resource "aws_security_group" "sg" {
  name        = "${var.prefix}-webserver-sg"
  description = "security group to allow inbound/outbound from the VPC"
  vpc_id      = var.vpc
  tags = {
    Nmae = "${var.prefix}-webserver-sg"
  }
}
resource "aws_security_group_rule" "ingress_ssh" {
  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  description              = "Allow SSH from Bastion"
  source_security_group_id = aws_security_group.bastion_sg.id  # Allow SSH from Bastion security group
}
resource "aws_security_group_rule" "ingress_http" {
  security_group_id        = aws_security_group.sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description              = "Allow http from loadbalancer"
}

resource "aws_security_group_rule" "egress_all" {
  security_group_id = aws_security_group.web.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_network_interface" "webserver_ni" {
  subnet_id = var.private_subnet

  security_groups = [
    aws_security_group.sg.id
  ]

  tags = {
    Name = "${var.prefix}-ni-webserver"
  }
}


resource "aws_instance" "webserver" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 8
    volume_type = "gp3"
  }
   # User data script to install nginx
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > /var/www/html/index.html
              yum update -y
              yum install -y nginx
              service nginx start
              chkconfig nginx on
              EOF
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.webserver_ni.id
  }

  tags = {
    Name = "${var.prefix}-webserver"
  }
}
