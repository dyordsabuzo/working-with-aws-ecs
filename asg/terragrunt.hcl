include {
  path = find_in_parent_folders()
}

terraform {
  source = "."
}

dependency "ecs" {
  config_path = "../ecs"
  mock_outputs = {
    cluster_name = "fake_name"
  }
}

inputs = {
  cluster_name = dependency.ecs.outputs.cluster_name
}
