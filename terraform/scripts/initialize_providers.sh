# Create a tiny module to pin providers
mkdir -p /tmp/tf-mirror && cat >/tmp/tf-mirror/versions.tf <<'EOF'
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"   # pin to what is inside Cloud One
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"  # pin to what is inside Cloud One
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"  # pin to what is inside Cloud One
    }
  }
}
EOF

# Lock for the runner platforms you use (adjust as needed)
terraform -chdir=/tmp/tf-mirror init -input=false -no-color
terraform -chdir=/tmp/tf-mirror providers lock -platform=linux_amd64 -platform=linux_arm64

# Materialize the mirror directory (THIS is what we’ll COPY into the image)
terraform -chdir=/tmp/tf-mirror providers mirror /tmp/provider-mirror
# Resulting structure (example):
# /tmp/provider-mirror/registry.terraform.io/hashicorp/aws/5.99.1/linux_amd64/...
# /tmp/provider-mirror/registry.terraform.io/hashicorp/tls/4.1.0/linux_amd64/...
# /tmp/provider-mirror/registry.terraform.io/hashicorp/null/3.2.4/linux_amd64/...
