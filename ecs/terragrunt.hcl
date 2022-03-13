include {
  path = find_in_parent_folders()
}

terraform {
  source = "tfr://app.terraform.io/pablosspot/pablosspot-ecs/aws?version=0.0.1"
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
  container_definition = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      cpu       = 512
      memory    = 512
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = dependency.db.outputs.dbhost
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = dependency.db.outputs.dbuser
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = dependency.db.outputs.dbname
        }
      ]
      secrets = [
        {
          name      = "WORDPRESS_DB_PASSWORD"
          valueFrom = dependency.db.outputs.dbpassword_arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = "ap-southeast-2"
          awslogs-group         = "/webapp-cluster/webapp"
          awslogs-stream-prefix = "wordpress"
        }
      }
    }])
}
