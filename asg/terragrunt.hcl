include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-asg/aws?version=0.0.1"
}

dependency "ecs" {
  config_path = "../ecs"
  mock_outputs = {
    cluster_name = "fake_name"
  }
}

inputs = {
  cluster_name = dependency.ecs.outputs.cluster_name
  system_name = "wordpress"
  application_port = 80

  user_data = templatefile("template/userdata.tpl", {
    cluster_name = dependency.ecs.outputs.cluster_name,
    nginx_conf = templatefile("template/server-conf.tpl", {
      nginx_port = 80
    })
  })
}
