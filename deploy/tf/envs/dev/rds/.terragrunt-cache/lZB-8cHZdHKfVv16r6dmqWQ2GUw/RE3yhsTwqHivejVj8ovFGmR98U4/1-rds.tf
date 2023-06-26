resource "aws_iam_role" "rds" {
  name = "${var.env}-${var.rds_name}-rds-cluster"

  assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "rds.amazonaws.com"
            },
            "Effect": "Allow"
            }
        ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "rds" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  role       = aws_iam_role.rds.name
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "${var.env}-${var.rds_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "aurora_sg" {
  name   = "${var.env}-${var.rds_name}-sg"
  vpc_id = var.vpc_id
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = "${var.env}-${var.rds_name}-cluster"
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  engine_mode             = "provisioned" # serverless v2
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet_group.name
  # master_username         = var.master_username
  # master_password         = var.master_password
  skip_final_snapshot     = true
  deletion_protection     = false
  
  # iam_database_authenticaVtion_enabled = true

  dynamic "serverlessv2_scaling_configuration" {
    for_each = length(var.serverlessv2_scaling_configuration) > 0 ? [var.serverlessv2_scaling_configuration] : []

    content {
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.rds,
    aws_db_subnet_group.aurora_subnet_group,
    aws_security_group.aurora_sg
    ]
}

resource "aws_rds_cluster_instance" "this" {
  cluster_identifier    = aws_rds_cluster.this.id
  db_subnet_group_name  = aws_db_subnet_group.aurora_subnet_group.name
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class        = var.rds_instance_class
}

resource "aws_security_group" "this" {
  name        = aws_db_subnet_group.aurora_subnet_group.name
  vpc_id      = var.vpc_id
  description = coalesce(aws_db_subnet_group.aurora_subnet_group.name, "Control traffic to/from RDS Aurora ${aws_rds_cluster.this.cluster_identifier}")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "this" {
  for_each = { for k, v in var.security_group_rules : k => v }

  # TODO: Still heavily coupled to RDS Aurora Postgres. 
  # Which is ok for now, but should be made more generic.

  # required
  type              = try(each.value.type, "ingress")
  from_port         = try(each.value.from_port, 5432) # has to be transformed into a parameter
  to_port           = try(each.value.to_port, 5432) # has to be transformed into a parameter
  protocol          = try(each.value.protocol, "tcp")
  security_group_id = aws_security_group.aurora_sg.id

  # optional
  cidr_blocks              = try(each.value.cidr_blocks, null)
  description              = try(each.value.description, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  prefix_list_ids          = try(each.value.prefix_list_ids, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
}