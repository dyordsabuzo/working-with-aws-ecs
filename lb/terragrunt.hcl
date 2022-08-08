include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-lb/aws?version=0.0.1"
}

inputs = {
  base_domain = "pablosspot.ml"
  system_name = "wordpress"
  application_port = 80
}
