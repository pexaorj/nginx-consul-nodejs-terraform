resource "aws_eip" "nat_a" {
  vpc      = true
}

resource "aws_eip" "nginx_a" {
  vpc      = true
}
