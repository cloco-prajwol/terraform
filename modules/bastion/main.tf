resource "aws_instance" "ecorange-testing" {

  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"

  tags = {
    Name = "prajwol-ecorange Terraform EC2 20250320"
  }
}
