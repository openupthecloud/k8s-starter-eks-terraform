
> Requires at least 1 t2.medium instance to run the 

### Step 1: Install dependencies (AWS, Terraform, Kubectl)

```sh
./install.sh
```

### Step 2: Deploy the infrastructure for the cluster

Update VPC default in `./variables.tf`

```sh
terraform apply
```

### Step 3: Connect KubeCTL to your cluster

* `aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks`

### Step 4: Create the namespace, deployment and service

1. `kubectl create namespace eks-sample-app`
2. `kubectl apply -f eks-sample-deployment.yaml`
3. `kubectl apply -f eks-sample-service.yaml`

### Check everthing is running

`kubectl get all -n eks-sample-app`

If you need to access your pod/service, run:

`kubectl exec -it <deployment-id> -n eks-sample-app -- /bin/bash`

For example: 

`kubectl exec -it eks-sample-linux-deployment-5b568bf897-5xkf7 -n eks-sample-app -- /bin/bash`
