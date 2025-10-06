terraform {
  required_providers {
    aws  = { source = "hashicorp/aws",  version = "5.99.1" }
    tls  = { source = "hashicorp/tls",  version = "4.1.0" }
    null = { source = "hashicorp/null", version = "3.2.4" }
  }
}
