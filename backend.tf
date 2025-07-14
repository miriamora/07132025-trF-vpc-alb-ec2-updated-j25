terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "**replace_with_your_bucket_name**"
    key          = "alb/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}