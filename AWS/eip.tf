resource "aws_eip" "lb1" {
  instance = aws_instance.myec2.id
  vpc      = true
}