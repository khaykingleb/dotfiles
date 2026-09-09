terraform {
  cloud {
    organization = "khaykingleb"

    workspaces {
      name = "github"
    }
  }

  required_version = "~> 1.16.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "khaykingleb"
}
