resource "aws_s3_bucket" "remote_s3" {
  bucket = "my-state-bucket-nikhil-2025"

  tags = {
    Name = "my-state-bucket-nikhil-2025"
  }
}