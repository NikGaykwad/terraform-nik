resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket-name}"

  tags = {
    Name = "${var.env}-${var.bucket-name}"
    Environment = var.env
  }
}