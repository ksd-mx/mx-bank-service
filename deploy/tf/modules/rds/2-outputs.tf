output "rds_cluster_identifier" {
  value = aws_rds_cluster.this.cluster_identifier
}

output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.this.endpoint
}

output "aurora_cluster_reader_endpoint" {
  value       = aws_rds_cluster.this.reader_endpoint
}

output "aurora_cluster_arn" {
  value       = aws_rds_cluster.this.arn
}