terraform {
  backend "gcs" {
    bucket = "test-bucket-infra-253316"
    prefix = "terraform/state/prod"
  }
}