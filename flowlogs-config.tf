resource "aws_flow_log" "terraformflowlogs" {
  log_destination      = aws_s3_bucket.terraform_flowlogs_bucket1.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.terraform_vpc_1.id
} 