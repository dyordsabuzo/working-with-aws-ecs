data "aws_availability_zones" "zones" {
  state = "available"
}

data "aws_subnet_ids" "subnets" {
  vpc_id = aws_default_vpc.default.id
}
