variable "location" {
  description = "Location of all resources"
  type        = string

  validation {
    condition     = length(regexall(" ", var.location)) == 0
    error_message = "Location must not contain spaces"
  }
}

variable "aks_sku_tier" {
  description = "AKS SKU Tier"
  type        = string
}

variable "aks_enable_auto_scaling" {
  description = "Enable AKS auto-scaling"
  type        = bool
  default     = false
}

variable "aks_agents_size" {
  description = "AKS agents size"
  type        = string
}

variable "aks_agents_count" {
  description = "AKS agents count"
  type        = number
  default     = null
}

variable "aks_agents_min_count" {
  description = "AKS agents min count"
  type        = number
  default     = null
}

variable "aks_agents_max_count" {
  description = "AKS agents max count"
  type        = number
  default     = null
}

variable "aks_agents_max_pods" {
  description = "AKS agents max pods"
  type        = number
  default     = null
}
