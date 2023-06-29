terraform {
  source = "../../../../../TerraformModules/terraform-rds/modules/rds"
}

include {
  path = find_in_parent_folders()
}

dependency "tags" {
  config_path = "../tags"
  mock_outputs    = {
    prefix_name = "dummy_prefix"

    commons = {
      email       = "dummy_user@dummymail.com"
      account_id  = get_aws_account_id()
      environment = "dummy_env"
    }
  }
}

dependency "secrets_manager" {
  config_path = "../secrets_manager"
  mock_outputs = {
    secrets_manager_id = "dummy_secret_manager_id"
  }
}

inputs = {
  prefix_name           = dependency.tags.outputs.prefix_name
  secrets_manager_id    = dependency.secrets_manager.outputs.secrets_manager_id
  tags                  = dependency.tags.outputs.commons
}