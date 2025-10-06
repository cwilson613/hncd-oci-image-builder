FROM hashicorp/terraform:1.13.3

# Use the baked CLI config by default (can be overridden per job)
ENV TF_CLI_CONFIG_FILE=/etc/terraform.rc

# Copy the strict offline config
COPY terraform.rc /etc/terraform.rc

# Copy the pre-fetched provider mirror (created on an online box)
# Directory must contain the 'registry.terraform.io/...' hierarchy
COPY mirror/ /opt/terraform/providers/

# Override entrypoint for CI/CD use (can be overridden per job)
ENTRYPOINT [ "" ]
