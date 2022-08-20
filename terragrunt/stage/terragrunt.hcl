remote_state {
  backend = "s3"
  config = {
    bucket = "jokernauten-terraform-state-s3"
    key = "${path_relative_to_include()}/terraform.tfstate"  
    dynamodb_table = "terraform-state-db"
    region         = "us-east-1"
    encrypt        = true
  }
}