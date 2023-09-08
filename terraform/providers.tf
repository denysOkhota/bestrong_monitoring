terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "dentfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    sas_token = "sp=racwdli&st=2023-09-08T11:54:08Z&se=2023-10-11T19:54:08Z&spr=https&sv=2022-11-02&sr=c&sig=kL3xoapIUwD7QuYFmZ9jDdRPuQqltZJswJpFj%2FXb%2F4Y%3D"
  }

}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = pathexpand(var.kube_config)
}