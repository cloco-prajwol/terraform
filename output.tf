output "is_key_pair_empty" {
  value = length(var.public_ssh_key) == 0 ? "The key pair is empty" : "The key pair is not empty, you will be able to ssh to ec2 instance"
}
