terraform {
  backend "s3" {
    bucket = "rs-terraform-statefiles"
    key    = "developerteam1/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
