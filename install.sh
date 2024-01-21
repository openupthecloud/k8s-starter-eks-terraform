#/bin/bash

# Install Terraform
TF_VERSION=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].version' | egrep -v 'rc|beta|alpha' | tail -1)

curl -LO "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
unzip terraform_${TF_VERSION}_linux_amd64.zip
sudo mv -f terraform /usr/local/bin/
rm terraform_${TF_VERSION}_linux_amd64.zip

# terraform init

# # Install KubeCTL
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.28.3/2023-11-14/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -rf kubectl

# # Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip
rm -rf aws

aws configure

terraform apply -var vpc_id=$(aws ec2 describe-vpcs | jq -r .Vpcs[0].VpcId)

aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks

# Create Kubernetes resources
kubectl create namespace eks-sample-app
kubectl apply -f eks-sample-deployment.yaml
kubectl apply -f eks-sample-service.yaml