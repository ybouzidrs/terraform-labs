resource "aws_instance" "app_server" {
  ami           = "ami-0416f96ae3d1a3f29"
  instance_type = "t2.micro"
}