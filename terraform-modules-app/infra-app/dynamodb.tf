resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "${var.env}-infra-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash-key

  attribute {
    name = var.hash-key
    type = "S" # S = String
  }

  tags = {
    Name = "${var.env}-infra-table"
    Environment = var.env
  }
}