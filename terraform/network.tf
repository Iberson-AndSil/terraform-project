# resource "aws_vpc" "vpc_example_app" {
#     cidr_block = "10.0.0.0/16"
#     enable_dns_hostnames = true
#     enable_dns_support = true
# }

# resource "aws_subnet" "public_a" {
#     vpc_id = "${aws_vpc.vpc_example_app.id}"
#     cidr_block = "10.0.1.0/24"
#     availability_zone = "${var.aws_region}a"
# }

# resource "aws_subnet" "public_b" {
#     vpc_id = "${aws_vpc.vpc_example_app.id}"
#     cidr_block = "10.0.2.0/24"
#     availability_zone = "${var.aws_region}b"
# }

# resource "aws_internet_gateway" "internet_gateway" {
#     vpc_id = "${aws_vpc.vpc_example_app.id}"
# }

# resource "aws_route" "internet_access" {
#     route_table_id = "${aws_vpc.vpc_example_app.main_route_table_id}"
#     destination_cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_internet_gateway.internet_gateway.id}"
# }

# # Create a security group to allow HTTP traffic to the ECS instances
# resource "aws_security_group" "ecs_sg" {
#   name = "ecs_sg_HolaMundoCloud"
#   vpc_id = "${aws_vpc.vpc_example_app.id}"

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# -------------------

resource "aws_security_group" "app_sg" {
  name        = "${var.app_name}-sg"
  description = "Allow HTTP and internal traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir acceso desde cualquier IP
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permitir acceso desde cualquier IP (puedes ajustar esto si deseas más restricciones)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Permitir todo el tráfico de salida
    cidr_blocks = ["0.0.0.0/0"]  # Permitir acceso a cualquier IP
  }
}

resource "aws_lb" "app_lb_network" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_sg.id]  # Usar el grupo de seguridad definido
  subnets            = var.subnet_ids
}

resource "aws_ecs_service" "service_network" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = true
    security_groups = [aws_security_group.app_sg.id]  # Usar el grupo de seguridad definido
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_target_group.arn
    container_name   = var.app_name
    container_port   = 3000
  }
}
