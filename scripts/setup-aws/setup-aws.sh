aws sso login --profile "$AWS_SETUP_PROFILE" >&2
aws sts get-caller-identity --profile "$AWS_SETUP_PROFILE" >&2
aws configure export-credentials --profile "$AWS_SETUP_PROFILE" --format env
