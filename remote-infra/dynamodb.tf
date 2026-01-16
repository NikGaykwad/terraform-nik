resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "my-state-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockId"

  attribute {
    name = "LockId"
    type = "S" # S = String
  }

  tags = {
    Name = "my-state-table"
  }
}

# "PAY_PER_REQUEST" - pay as you hit request
# "PROVISIONED" - Charegeble for month