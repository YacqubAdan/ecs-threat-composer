terraform {
  backend "s3" {
    bucket         = "tf-backend-threatcomposer"       
    key            = "terraform.tfstate"   
    region         = "eu-west-2"               
    dynamodb_table = "tf-backend"  
    encrypt        = true
  }
}