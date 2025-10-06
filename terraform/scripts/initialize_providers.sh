# Create a tiny module to pin providers
mkdir -p ~/tf-mirror && cat >~/tf-mirror/versions.tf <<'EOF'
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
terraform -chdir=~/tf-mirror init -input=false -no-color
terraform -chdir=~/tf-mirror providers lock -platform=linux_amd64 -platform=linux_arm64

# Materialize the mirror directory (THIS is what we’ll COPY into the image)
terraform -chdir=~/tf-mirror providers mirror ~/provider-mirror
# Resulting structure (example):
# ~/provider-mirror/registry.terraform.io/hashicorp/aws/5.99.1/linux_amd64/...
# ~/provider-mirror/registry.terraform.io/hashicorp/tls/4.1.0/linux_amd64/...
# ~/provider-mirror/registry.terraform.io/hashicorp/null/3.2.4/linux_amd64/...
