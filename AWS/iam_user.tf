resource "aws_iam_user" "lb1" {
  name  = "loadbalancer.${count.index}"
  count = 3
  path  = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_user" "lb" {
  name  = var.elb_names[count.index]
  path  = "/system/"
  count = 3
}