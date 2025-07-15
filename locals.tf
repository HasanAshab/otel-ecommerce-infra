locals {
  project_name  = "otel-ecommerce"
  naming_suffix = [local.project_name, terraform.workspace, var.location]
}
