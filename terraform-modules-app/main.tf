module "dev" {

  source              = "./infra-app"
  env                 = "dev"
  bucket-name         = "nik-infra-bucket-2025"
  instance_count      = 1
  ec2_instance_type   = "t2.micro"
  ec2_instance_ami_id = "ami-02d26659fd82cf299"
  hash-key            = "student_id"
}

module "stg" {

  source              = "./infra-app"
  env                 = "stg"
  bucket-name        = "nik-infra-bucket-2025"
  instance_count      = 1
  ec2_instance_type   = "t2.micro"
  ec2_instance_ami_id = "ami-02d26659fd82cf299"
  hash-key            = "student_id"
}

module "prod" {

  source              = "./infra-app"
  env                 = "prod"
  bucket-name        = "nik-infra-bucket-2025"
  instance_count      = 1
  ec2_instance_type   = "t2.micro"
  ec2_instance_ami_id = "ami-02d26659fd82cf299"
  hash-key            = "student_id"
}