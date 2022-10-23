resource "aws_iam_user" "lb" {
  name = "${var.elb_names[count.index]}"
  path = "/system/"
  count = 3
}