terraform {
  backend "s3" {
    region       = "us-east-1"
    bucket       = "testbucketforalb-20250714"
    key          = "alb/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
  }
}