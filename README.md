# terraform
terraform fmt
terraform plan -out=tfplan
terraform apply tfplan  -var-file="dev.tfvars"
terraform destroy