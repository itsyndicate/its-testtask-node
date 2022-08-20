include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:jokernauten/its.git//efs?ref=v0.0.8"
}

inputs = {
    efs_name = "its_efs"
}