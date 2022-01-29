include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

dependency "lb" {
  config_path = "../lb"
  mock_outputs = {
    target_group_arn = "fake_arn"
  }
}

dependency "db" {
  config_path = "../db"
  skip_outputs = true
}

inputs = {
  cluster_name = "webapp-cluster"
  service_name = "webapp"
  task_family = "wordpress"
  target_group_arn = dependency.lb.outputs.target_group_arn
}
