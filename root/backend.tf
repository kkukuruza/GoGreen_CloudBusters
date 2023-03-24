terraform {
  backend "s3" {
    bucket = "kkukuruza-7"
    key    = "tfstate_go_green"
    region = "us-east-1"
  }
}
