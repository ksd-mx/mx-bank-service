resource "aws_security_group" "vpc_link" {
  name = "${aws_apigatewayv2_api.this.name}-private-link-sg"
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_apigatewayv2_vpc_link" "eks" {
  name = "${aws_apigatewayv2_api.this.name}-private-link-eks"
  security_group_ids = [aws_security_group.vpc_link.id]
  subnet_ids = var.subnet_ids
}