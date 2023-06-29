terraform {
    source = "../../../../../TerraformModules/terraform-eks-news-feed/modules/system"
}

include {
    path = find_in_parent_folders()
}

dependency "tags" {
    config_path     = "../tags"
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
        secrets_manager_arn = "dummy_arn"
    }
}

inputs = {
    prefix_name             = dependency.tags.outputs.prefix_name
    secrets_manager_arn     = dependency.secrets_manager.outputs.secrets_manager_arn
    tags                    = dependency.tags.outputs.commons
}