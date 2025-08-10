terraform {
  backend "s3" {
    bucket       = "testingggggg-manideep"
    key          = "test-env/terraform.tfstate"
    use_lockfile = true
    encrypt      = true
    region       = "ap-south-1"
  }
}
