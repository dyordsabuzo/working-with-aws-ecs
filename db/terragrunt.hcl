include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-rds/aws?version=0.0.7"
}

inputs = {
  database_name = "wordpressdb"
  database_master_username = "wordpressdbuser"
  system_name = "wordpress"
}
