variable "subscription_id" {
  description = "The subscription ID for the Azure account"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
  default     = "centralindia" # Default location, change if needed
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "tamm-aks-rg"
}

variable "tag" {
  description = "A tag to be applied to resources"
  type        = string
  default     = "Dev"
}
variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "The SKU (pricing tier) of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Whether to enable admin user for the Azure Container Registry"
  type        = bool
  default     = true
}

