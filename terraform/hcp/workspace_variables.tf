resource "tfe_variable" "github_token" {
  key              = "GITHUB_TOKEN"
  category         = "env"
  description      = "GitHub provider token"
  sensitive        = true
  workspace_id     = data.tfe_workspace.github.id
  value_wo         = var.github_token
  value_wo_version = 1
}
