resource "aws_instance" "myecModule" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = var.instance_type
}
