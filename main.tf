terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" // Specify a recent, compatible version
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.40" // Specify a recent, compatible version (check latest)
    }
    random = { # The aws-workspace-basic module also uses the random provider
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.region
  // Ensure your AWS credentials are configured.
  // This can be via environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN),
  // shared credentials file (~/.aws/credentials), or an IAM role.
}

provider "databricks" {
  // For account-level operations like creating workspaces.
  // Authentication is expected to be configured via environment variables:
  //   DATABRICKS_HOST (e.g., https://accounts.cloud.databricks.com)
  //   DATABRICKS_ACCOUNT_ID (your Databricks E2 Account ID - also set as a variable for module input)
  //   DATABRICKS_CLIENT_ID (for an account-level service principal)
  //   DATABRICKS_CLIENT_SECRET (for an account-level service principal)
}

module "aws-workspace-basic" {
  source                = "github.com/databricks/terraform-databricks-examples/modules/aws-workspace-basic"
  databricks_account_id = var.databricks_account_id
  region                = var.region
  tags                  = var.tags
  prefix                = var.prefix
  cidr_block            = var.cidr_block
}