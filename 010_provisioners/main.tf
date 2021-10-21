terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  # Configuration options
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "set-your-profile"
  region                  = "us-east-1"
}
resource "aws_instance" "app_server" {
  ami           = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name = "serguy"

  tags = {
    Name = "serguy-ec2-instance"
  }

  provisioner "local-exec" {
    command = "echo instance_id: ${self.id} > instance_details.txt; echo private_ip: ${self.private_ip} >> instance_details.txt; echo public_ip: ${self.public_ip} >> instance_details.txt"
  }

  # provisioner "local-exec" {
  #   command = "echo $KEY $SECRET > cerdentials.yml"
    
  #   environment = {
  #     KEY = "GIUEXXHUIOPMEK"
  #     SECRET = "APOx38KDJG0828hhgPIOL"
  #    }
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update -y",
  #     "sudo yum install -y httpd",
  #     "sudo systemctl start httpd",
  #   ]

  #   connection {
  #   type     = "ssh"
  #   user     = "ec2-user"
  #   host = self.public_ip
  #   private_key = "${file("~/Downloads/serguy.pem")}"
  #   }
  # }
  provisioner "file" {
    source = "./web.sh"
    destination = "/home/ec2-user/web.sh"
    
    connection {
    type     = "ssh"
    user     = "ec2-user"
    host = self.public_ip
    private_key = "${file("~/Downloads/serguy.pem")}"
    }
  }

  provisioner "remote-exec" {

    inline = [
      "cd /home/ec2-user/",
      "chmod +x web.sh",
      "./web.sh"
    ]
    
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file(("~/Downloads/serguy.pem"))
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "null_resource" "completion_date" {
#   provisioner "local-exec" {
#     command = "date > completion_date.txt" 
#   }
# }

# data "template_file" "private_key" {
#   template = file("~/Downloads/serguy.pem")  
# }