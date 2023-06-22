resource "aws_ecr_repository" "this" {
  name = "${var.env}-${var.repository_name}-repository"
}