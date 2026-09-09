terraform {
  cloud {
    organization = "khaykingleb"
    workspaces {
      name = "hcp"
    }
  }

  required_version = "~> 1.16.0"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.80.0"
    }
  }
}

provider "tfe" {
  organization = "khaykingleb"
}
