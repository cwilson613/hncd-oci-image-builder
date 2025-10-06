# 1) Put temp on real disk
export TMPDIR=$HOME/.tmp-tf
mkdir -p "$TMPDIR"

# 2) (Nice-to-have) cache provider zips so repeated runs don’t re-download
export TF_PLUGIN_CACHE_DIR=$HOME/.terraform.d/plugin-cache
mkdir -p "$TF_PLUGIN_CACHE_DIR"

# 3) Run your steps again
terraform -chdir=~/tf-mirror init -input=false -no-color
terraform -chdir=~/tf-mirror providers lock -platform=linux_amd64 -platform=linux_arm64
terraform -chdir=~/tf-mirror providers mirror ~/provider-mirror
