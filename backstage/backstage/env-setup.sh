export AWS_EKS_CLUSTER_URL="$(terraform -chdir=kubernetes-infra output -raw eks_cluster_endpoint)"
export AWS_EKS_CA="$(terraform -chdir=kubernetes-infra output -raw eks_cluster_certificate_authority)"
export AWS_OIDC_URL="$(terraform -chdir=kubernetes-infra output -raw eks_cluster_oidc)"
export AWS_ACCESS_KEY_ID="$(aws --profile default configure get aws_access_key_id)"
export AWS_SECRET_ACCESS_KEY="$(aws --profile default configure get aws_secret_access_key)"

echo "Set cluster URL and cert authority"