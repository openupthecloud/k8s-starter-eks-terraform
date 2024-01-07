# Kubernetes Experiments

Install AWS CLI and Kubectl

```sh
./install.sh
```

* Create cluster: https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html
* Create node role: https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html#create-worker-node-role
* Create with Terraform: https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks

Use AWS CLI to generate a kubeconfig

```sh
aws eks update-kubeconfig --region us-east-1  --name lou-test
```

```sh
kubectl get svc
```

Create the namespace
```sh
kubectl apply -f eks-sample-deployment.yaml
```

```sh
 kubectl apply -f eks-sample-service.yaml
```

**References:**

* [Deploy a sample application EKS](https://docs.aws.amazon.com/eks/latest/userguide/sample-deployment.html)