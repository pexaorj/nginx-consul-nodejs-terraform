resource "aws_key_pair" "debug" {
    key_name = "debug-key"
    public_key = "${file("ssh_keys/debug-key.pub")}"
}
