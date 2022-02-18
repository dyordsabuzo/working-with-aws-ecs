#!/bin/bash
sudo apt update && sudo apt upgrade -y

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

mkdir -p /var/nginx

echo "${nginx_conf}" > /var/nginx/server.conf

private_ip=$(hostname -i)
sed -i -e "s/wordpress/$private_ip/g" /var/nginx/server.conf

echo "ECS_CLUSTER=${cluster_name}" >> /etc/ecs/ecs.config