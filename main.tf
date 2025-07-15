module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa" # v0.4.2
  suffix = local.naming_suffix
}

resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name
  location = var.location
}

module "aks" {
  source = "git::https://github.com/Azure/terraform-azurerm-aks.git?ref=9b39485" # v10.2.0
  # source              = "Azure/aks/azurerm"
  # version             = "10.2.0"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  cluster_name        = module.naming.kubernetes_cluster.name
  sku_tier            = var.aks_sku_tier
  enable_auto_scaling = var.aks_enable_auto_scaling
  agents_size         = var.aks_agents_size
  agents_count        = var.aks_enable_auto_scaling ? null : var.aks_agents_count
  agents_min_count    = var.aks_agents_min_count
  agents_max_count    = var.aks_agents_max_count
}
