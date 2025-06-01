terraform {
  backend "s3" {
    bucket = "sara-terraform-state-backend" #  this bucket is created manually
    key    = "terrform.tfstate"
    region = "us-east-1"
  }
}
