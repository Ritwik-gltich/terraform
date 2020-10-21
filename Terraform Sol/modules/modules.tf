provider "aws" {
  //alias      = "Env01"
  region     = "us-east-2"
  access_key = "AKIAJGMF4ONED5G63IPQ"
  secret_key = "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"
}

// This would create the first EC2 instance and the private key would be stored in the terraform state file
// This would create the first EC2 instance
module "ec2-01" {
    source = "./ec2"
    ami = "ami-03657b56516ab7912"
    instance_type = "t3.micro"
    name_tag = "Vm01"
    availability_zone = "us-east-2a"
    subnet_name = "subnet-az-2a"
    key_name = module.key01.key-name
}

module "key01" {
    source = "./key-pair"
    key_name = "Key1"    
}

output "ec2-01-id" {
  value = module.ec2-01.ec2-instance-id
}

output "Pub-pri-key01" {
  value = map (
    "Public-Key", module.key01.public_key,
    "private-Key", module.key01.private_key
  )
}

// This would create the 2nd EC2 instance and the private key would be stored in the terraform state file
module "ec2-02" {
    source = "./ec2"
    ami = "ami-03657b56516ab7912"
    instance_type = "t3.micro"
    name_tag = "Vm02"
    availability_zone = "us-east-2b"
    subnet_name = "subnet-az-2b"
    key_name = module.key01.key-name
}

module "key02" {
    source = "./key-pair"
    key_name = "Key2"    
}

output "ec2-02-id" {
  value = module.ec2-02.ec2-instance-id
}

output "Pub-pri-key02" {
  value = map (
    "Public-Key", module.key02.public_key,
    "private-Key", module.key02.private_key
  )
}

// This would create the 3rd EC2 instance and the private key would be stored in the terraform state file
module "ec2-03" {
    source = "./ec2"
    ami = "ami-03657b56516ab7912"
    instance_type = "t3.micro"
    name_tag = "Vm03"
    availability_zone = "us-east-2c"
    subnet_name = "subnet-az-2c"
    key_name = module.key01.key-name
}

module "key03" {
    source = "./key-pair"
    key_name = "Key3"    
}

output "ec2-03-id" {
  value = module.ec2-03.ec2-instance-id
}

output "Pub-pri-key03" {
  value = map (
    "Public-Key", module.key03.public_key,
    "private-Key", module.key03.private_key
  )
}