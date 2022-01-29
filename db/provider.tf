provider "aws" {
  region = var.region

  default_tags {
    tags = {
      created_by = "terraform"
      stack      = "rds-stack"
    }
  }
}
