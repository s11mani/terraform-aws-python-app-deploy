terraform {
  backend "s3" {
    bucket       = "openai-terraform-demo-s3-bucket"
    key          = "demo-env/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
    region       = "ap-south-1"
  }
}
