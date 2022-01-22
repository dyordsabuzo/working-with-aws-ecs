terraform {
  backend "remote" {
    hostname     = "api.terraform.io"
    organization = "pablosspot"

    worworkspaces {
      prefix = "ps-wordpress-asg-"
    }
  }
}
