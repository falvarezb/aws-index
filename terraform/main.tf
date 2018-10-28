
module "launcher-eu-west-1" {
  source = "./launcher"
  region = "eu-west-1"
  ami = "ami-0ab7944c6328200be"
  name = "${var.name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "launcher-ap-southeast-2" {
  source = "./launcher"
  region = "ap-southeast-2"
  ami = "ami-00cc4908ffe2edda3"
  name = "${var.name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


module "launcher-sa-east-1" {
  source = "./launcher"
  region = "sa-east-1"
  ami = "ami-0f1253070285f5e5d"
  name = "${var.name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "launcher-us-west-2" {
  source = "./launcher"
  region = "us-west-2"
  ami = "ami-09bfeda7337019518"
  name = "${var.name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

