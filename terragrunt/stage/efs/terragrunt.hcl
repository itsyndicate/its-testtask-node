include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:negrych-vladyslav/its.git//efs"
}

inputs = {
    efs_name = "its_efs"
}
