output "example_tlscert" {
  description = "The TLS certificate from ACME."
  value       = module.example-tlscert.tls_cert
}

