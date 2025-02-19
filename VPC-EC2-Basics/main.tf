terraform {
  # backend "remote" {
  #   organization = "Demos_Terraform_associate"

  #   workspaces {
  #     name = "test_01"
  #   }
  # }
   cloud {
    organization = "Demos_Terraform_associate"

    workspaces {
      name = "test_01"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}


locals {
  project_name = "chethiya"

}
