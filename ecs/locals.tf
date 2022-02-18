locals {
  volume_mapping = [
    {
      name          = "nginx-conf"
      host_path     = "/var/nginx/server.conf"
      containerPath = "/etc/nginx/conf.d/default.conf"
      readOnly      = false
    }
  ]
}
