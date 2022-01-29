include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

inputs = {
  database_name = "wordpress-db"
  database_master_username = "wordpress-dbuser"
}
