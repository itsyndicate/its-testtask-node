resource "aws_efs_file_system" "efs" {
  creation_token = "efs"
  encrypted      = "true"
  tags = {
    Name = var.efs_name
  }
}
