resource "aws_apigatewayv2_integration" "eks" {
  api_id = aws_apigatewayv2_api.this.id

#   integration_uri = var.integration_url
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.eks.id
}

resource "aws_apigatewayv2_route" "eks" {
  api_id = aws_apigatewayv2_api.this.id
  route_key = "ANY /"
  target = "integrations/${aws_apigatewayv2_integration.eks.id}"
}