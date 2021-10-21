provider "aws" {
  # Configuration options
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "set-your-profile"
  region                  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"

  tags = {
    Name = "serguy-virtual-machine"
    Project = "hashicorp terraform training"
  }

  lifecycle {
    create_before_destroy = true
  }
}