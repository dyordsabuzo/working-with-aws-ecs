include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

inputs = {
  database_name = "wordpressdb"
  database_master_username = "wordpressdbuser"
}
