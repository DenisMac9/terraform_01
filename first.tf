provider "aws" {
  access_key = "cc"
  secret_key = "xx"
  region     = "eu-west-3a"
}
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}