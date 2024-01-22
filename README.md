The purpose of this repo is to give you a very minimal EKS cluster for the purpose of learning Kubernetes using Terraform. The cluster is a great foundation for starting to learn what it might take to manage a production-ready Kubernetes cluster in AWS on EKS, deployed through Terraform. The starter is intentionally a minimal starter, and is not an entirely production-ready cluster (e.g. no remote state for terraform setup, the single node setup is insufficient, etc). The starter, however is a great jumping off point to start to iterate on the given configuration to add your own complexity and features yourself. 

![image](https://github.com/openupthecloud/k8s-starter-eks-terraform/assets/5528307/9df77164-c4b2-4107-8802-bb06871ae4c1)

### Prerequisite knowledge

You do not need to be a master of all of the below technologies, but you do at least need to know what they are, what they do, and be comfortable modifying them if you need to debug anything. For instance, if you have never deployed an EC2 instance into AWS using Terraform (or a similar tool), that would be a better starting point than this repository. 

1. **Linux** - Installing packages, configuring environment variables and configuration files, using commands, flags, etc. 
1. **AWS Compute & Networking Foundations** - e.g. EC2, Subnets, VPC.
1. **Kubernetes** - Understanding of the reasons for using Kubernetes, and basic terminology. 

## Related Documentation

This repository is based on the following documentation: 

* [Getting started with EKS Clusters](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
* [Deploying a sample workload](https://docs.aws.amazon.com/eks/latest/userguide/sample-deployment.html)
* [Expose service running on EKS cluster](https://repost.aws/knowledge-center/eks-kubernetes-services-cluster)
* [EKS Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-eks)

## Getting Started

> Requires at least 1 t2.medium instance to run the required containers and the workload. 

### Step 1: Install dependencies (AWS, Terraform, Kubectl)

```sh
./install.sh
```

### Step 2: Deploy the infrastructure with Terraform

Update VPC default in `./variables.tf`

```sh
terraform apply
```

Or pass it as the vpc ID variable:

```sh
terraform apply -var vpc_id=$(aws ec2 describe-vpcs | jq -r .Vpcs[0].VpcId)
```

### Step 3: Connect KubeCTL to the deployed cluster

```sh
aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks
```

### Step 4: Create an app with a deployment and service

```sh
kubectl apply -f app.yaml
```

### FAQs

#### Why not create the cluster manually? 

By using Terraform we can easily create and destroy our infrastructure repeatedly. It's hard sometimes using the AWS interface to know what you really did, or what was deployed. It would not be wise in a production environment to use this "ClickOps" approach, so we avoid that practice here, and start with a foundation that can scale towards production-ready. 

#### Why not use EKSCTL? 

Terraform is a widely adopted tool that works across a lot more technology than just Kubernetes. If the rest of your infrastructure in AWS is defined in Kubernetes, it would make sense to deploy your cluster in Terraform to take advantage of connecting features such as Terraform outputs, etc. Terraform also gives you a lot of fine-grained control. At some point, abstractions like EKSCTL start to break down. Starting with Terraform from the beginning avoids the need to migrate to Terraform or a more flexible provisioning tool later. Don't believe me, see [this StackOverflow thread](https://stackoverflow.com/questions/65497019/aws-eks-from-scratch-terraform-or-eksctl).

#### Why not use [minikube](https://minikube.sigs.k8s.io/docs/), [kind](https://kind.sigs.k8s.io/), or other local Kubernetes tools? 

The local K8s replication tools are useful for learning the terminology behind Kubernetes, however they will not allow you to see how it feels to run a Kubernetes cluster in a more production environment. A managed service like EKS abstracts some of the control plane concerns away so there is a lower complexity, however the abstractions with other native cloud services such as EC2, Load Balancers etc are useful to understand and cannot be learned through a local Kubernetes emulation tool. 

#### How can I see what is running in my cluster when deployed?

`kubectl get pods -n eks-sample-app`
`kubectl get all -n eks-sample-app`

#### How can I debug my deployed service?

You can access your running pod or service by running:

`kubectl exec -it <deployment-id> -n eks-sample-app -- /bin/bash`

For example: 

`kubectl exec -it eks-sample-linux-deployment-5b568bf897-5xkf7 -n eks-sample-app -- /bin/bash`

#### How can I visualise what is deployed in the terraform module? 

Running `terraform state show` will show you the list of resources inside your module once deployed. Using `terraform graph` you can also export your graph to a tool like: https://edotor.net/ to visualise the infra. However, be careful not to share any sensitive information contained in your state file(s) with external or 3rd parties. 
