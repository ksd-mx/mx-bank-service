output "rds_cluster_identifier" {
  value = aws_rds_cluster.this.cluster_identifier
}

output "aurora_cluster_endpoint" {
  description = "Endpoint for the Aurora Serverless DB cluster"
  value       = aws_rds_cluster.this.endpoint
}

output "aurora_cluster_arn" {
  description = "ARN of the Aurora Serverless DB cluster"
  value       = aws_rds_cluster.this.arn
}