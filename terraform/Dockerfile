FROM hashicorp/terraform:1.13.3

# Use the baked CLI config by default (can be overridden per job)
ENV TF_CLI_CONFIG_FILE=/etc/terraform.rc

COPY artifacts/terraform.rc /etc/terraform.rc
COPY mirror/ /opt/terraform/providers/


# Override entrypoint for CI/CD use (can be overridden per job)
ENTRYPOINT [ "" ]
