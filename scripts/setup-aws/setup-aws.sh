aws sso login --profile "$AWS_SETUP_PROFILE"
aws sts get-caller-identity --profile "$AWS_SETUP_PROFILE"
eval "$(aws configure export-credentials --profile "$AWS_SETUP_PROFILE" --format env)"
