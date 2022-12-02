module "ec2modulews" {
  source        = "./modules/ec2"
  instance_type = lookup(var.instance_typews, terraform.workspace)

}