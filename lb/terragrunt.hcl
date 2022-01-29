include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

inputs = {
  base_domain = "pablosspot.ga"
}
