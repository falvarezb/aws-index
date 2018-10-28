variable region { }
variable name { }
variable ec2_instance_type { }
variable ami { }
variable access_key { }
variable secret_key { }

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_security_group" "aws-index" {
  #provider = "aws.myregion"
  name = "${var.name}"
  description = "Allow HTTP and SSH traffic"

# SSH access from anywhere
 ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

# Access from anywhere
  ingress {
   from_port = 3001
   to_port = 3001
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "aws-index" {
  key_name   = "${var.name}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "aws-index" {
  ami = "${var.ami}" 
  #provider = "aws.myregion"
  instance_type = "${var.ec2_instance_type}"

   # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.aws-index.key_name}"

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.aws-index.name}"]

  tags {
    Name = "${var.name}"
  }

  # Copies the app folder to /home/ubuntu/app
  provisioner "file" {
    source      = "~/MyProjects/aws-index/app/config.js"
    destination = "/home/ubuntu/config.js"
    connection {
      user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "~/MyProjects/aws-index/app/http-server.js"
    destination = "/home/ubuntu/http-server.js"
    connection {
      user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "~/MyProjects/aws-index/app/index.js"
    destination = "/home/ubuntu/index.js"
    connection {
      user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "~/MyProjects/aws-index/app/knexfile.js"
    destination = "/home/ubuntu/knexfile.js"
    connection {
      user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "~/MyProjects/aws-index/app/package.json"
    destination = "/home/ubuntu/package.json"
    connection {
      user = "ubuntu"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -",
      "sudo apt-get install -y nodejs",
      "cd /home/ubuntu",
      "npm install"
    ]
    connection {
      user = "ubuntu"
    }
  }
}


output "public_dns" {
   value = "${join(",", aws_instance.aws-index.*.public_dns)}"
}



