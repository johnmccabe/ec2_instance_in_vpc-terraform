variable "aws_region" {
  description = "Region for the VPC"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "ami" {
  description = "Ubuntu Xenial AMI"
  default     = "ami-f90a4880"
}

variable "public_key_path" {
  description = "SSH Public Key path"
  default     = "../keypairs/nyx-test-keypair-nopassword.id_rsa.pub"
}

variable "private_key_path" {
  description = "SSH Private Key path"
  default     = "../keypairs/nyx-test-keypair-nopassword.id_rsa"
}
