
resource "aws_s3_bucket" "terraform_flowlogs_bucket1" {
  bucket = "terraformflowlogsbucket1"
  tags = {
    Name        = "terraformflowlogsbucket1"
    Environment = "Dev"
  }
  depends_on = [aws_s3_bucket.terraform_flowlogs_bucket2]
  lifecycle {
    prevent_destroy       = false
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "terraform_flowlogs_bucket2" {
  bucket = "terraformflowlogsbucket2"
  tags = {
    Name        = "terraformflowlogsbucket2"
    Environment = "Dev"
  }
  depends_on = [aws_s3_bucket.terraform_flowlogs_bucket3]
}

resource "aws_s3_bucket" "terraform_flowlogs_bucket3" {
  bucket = "terraformflowlogsbucket3"
  tags = {
    Name        = "terraformflowlogsbucket3"
    Environment = "Dev"
  }
  depends_on = [aws_route_table_association.terraform-public-1]
}