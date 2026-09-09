variable "github_token" {
  description = "GitHub token written to the GitHub workspace"
  type        = string
  sensitive   = true
  ephemeral   = true
}
