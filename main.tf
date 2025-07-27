resource "null_resource" "validate" {
  lifecycle {
    precondition {
      condition     = var.aks_enable_auto_scaling ? var.aks_agents_min_count != null && var.aks_agents_max_count != null : true
      error_message = "When auto scaling is enabled, `aks_agents_min_count` and `aks_agents_max_count` must be set."
    }

    precondition {
      condition     = !var.aks_enable_auto_scaling ? var.aks_agents_count != null : true
      error_message = "When auto scaling is disabled, `aks_agents_count` must be set."
    }
  }
}

resource "random_id" "prefix" {
  byte_length = 8
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa" # v0.4.2
  suffix = local.naming_suffix
}

resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name
  location = var.location
}

module "aks" {
  source                               = "git::https://github.com/Azure/terraform-azurerm-aks.git?ref=9b39485" # v10.2.0
  resource_group_name                  = azurerm_resource_group.this.name
  location                             = azurerm_resource_group.this.location
  prefix                               = random_id.prefix.hex
  cluster_name                         = module.naming.kubernetes_cluster.name
  cluster_log_analytics_workspace_name = module.naming.log_analytics_workspace.name
  sku_tier                             = var.aks_sku_tier
  enable_auto_scaling                  = var.aks_enable_auto_scaling
  agents_size                          = var.aks_agents_size
  agents_count                         = var.aks_enable_auto_scaling ? null : var.aks_agents_count
  agents_min_count                     = var.aks_agents_min_count
  agents_max_count                     = var.aks_agents_max_count
  agents_max_pods                      = var.aks_agents_max_pods
  network_plugin                       = "azure"

  # this module uses data source on rg so it should be created first
  # from : ovi
  # msg: It should be created first and also will created first because of
  # azurerm_resource_group.this.name & azurerm_resource_group.this.location then why
  # used depends on
  depends_on = [azurerm_resource_group.this]
}
