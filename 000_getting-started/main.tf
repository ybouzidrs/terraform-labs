provider "aws" {
  # Configuration options
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
  region                  = "us-east-1"
}
resource "aws_instance" "app_server" {
  ami           = "ami-0416f96ae3d1a3f29"
  instance_type = "t2.micro"

  tags = {
    Name = "name-ec2-instance"
  }
}