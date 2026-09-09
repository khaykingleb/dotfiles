# HCP Terraform

Manages variables for existing HCP Terraform workspaces.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.16.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.80.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.80.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [tfe_variable.github_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.github](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token written to the GitHub workspace | `string` | n/a | yes |
<!-- END_TF_DOCS -->
