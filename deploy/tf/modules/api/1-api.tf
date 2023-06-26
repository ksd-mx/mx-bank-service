resource "aws_apigatewayv2_api" "this" {
  name = "${var.env}-${var.api_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.this.id
  name = "dev"
  auto_deploy = true
}
