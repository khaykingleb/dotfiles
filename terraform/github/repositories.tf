locals {
  repositories = {
    dotfiles = {
      description = "Declarative macOS configuration managed with Nix"
      visibility  = "public"
      topics = [
        "claude-code",
        "cursor",
        "dotfiles",
        "home-manager",
        "macos",
        "mcp",
        "nix",
        "nix-darwin",
        "terraform",
      ]
    }
    dotfiles-private = {
      visibility = "private"
      topics     = []
    }
    ml-experiments = {
      description = "Playground for exploring machine learning models and systems"
      visibility  = "public"
      topics = [
        "deep-learning",
        "kubernetes",
        "hydra",
        "keyword-spotting",
        "machine-learning",
        "pytorch",
        "pytorch-lightning",
        "speech-recognition",
        "text-to-speech",
        "wandb",
      ]
    }
    website = {
      description  = "Personal website on Next.js"
      homepage_url = "https://khaykingleb.com"
      visibility   = "public"
      topics = [
        "nextjs",
        "notion-api",
        "personal-website",
        "supabase",
        "typescript",
        "vercel",
      ]
    }
  }
}

resource "github_repository" "repositories" {
  for_each = local.repositories

  name         = each.key
  visibility   = each.value.visibility
  description  = try(each.value.description, null)
  homepage_url = try(each.value.homepage_url, null)
  topics       = each.value.topics

  has_issues   = true
  has_projects = false
  has_wiki     = false

  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  archive_on_destroy = true

  lifecycle {
    prevent_destroy = true
  }
}
