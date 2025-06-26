terraform {
  backend "s3" {
    bucket         = "tf-backend-threatmodeller"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-backend-lock"
    encrypt        = true
  }
}
