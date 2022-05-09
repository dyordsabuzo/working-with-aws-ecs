include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-ecs/aws?version=0.0.12"
}

dependency "lb" {
  config_path = "../lb"
  mock_outputs = {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:123456789012:loadbalancer/app/my-load-balancer/1234567890123456"
  }
}

dependency "db" {
  config_path = "../db"
  mock_outputs = {
    dbhost = "fake"
    dbname = "fake"
    dbuser = "fake"
    dbpassword_arn = "arn:aws:ssm:ap-southeast-2::parameter/fake"
  }
}

inputs = {
  cluster_name = "webapp-cluster"
  service_name = "webapp"
  task_family = "wordpress"
  target_group_arn = dependency.lb.outputs.target_group_arn
  main_container_port = 80
  container_definitions = [
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      cpu       = 512
      memory    = 512
      essential = true
      container_port = 80
      environment = {
          WORDPRESS_DB_HOST = dependency.db.outputs.dbhost
          WORDPRESS_DB_USER = dependency.db.outputs.dbuser
          WORDPRESS_DB_NAME = dependency.db.outputs.dbname
      }
      secrets = {
          WORDPRESS_DB_PASSWORD = dependency.db.outputs.dbpassword_arn
      }
    }]
}
