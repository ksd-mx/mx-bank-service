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
  policy_arn = "arn:aws:iam::aws:policy/AmazonrdsClusterPolicy"
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
  master_username         = var.master_username
  master_password         = var.master_password
  skip_final_snapshot     = true
  deletion_protection     = false
  # iam_database_authenticaVtion_enabled = true

  depends_on = [
    aws_iam_role_policy_attachment.rds,
    aws_db_subnet_group.aurora_subnet_group,
    aws_security_group.aurora_sg
    ]
}