include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-lb/aws?version=0.0.1"
}

