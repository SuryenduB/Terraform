output "eip" {
  value = aws_eip.lb.public_ip
}

output "mys3bucket" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}



output "timestamp" {
  value = local.time
}

output "arns" {
    value = aws_iam_user.lb1[*].arn
  
}

output "names" {
    value = aws_iam_user.lb1[*].name
  
}