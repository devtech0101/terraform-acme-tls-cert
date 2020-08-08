variable "hostname" {
  description = "The hostname to use for the TLS certificate."
  type        = string
}

variable "email_address" {
  description = "The email address to use as a contact point for the TLS certificate."
  type        = string
}

variable "namecheap_api_user" {
  description = "The user to authenticate with against Namecheap API for the challenge."
  type        = string
}

variable "namecheap_api_key" {
  description = "The key to authenticate with against Namecheap API for the challenge."
  type        = string
}