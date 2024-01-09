
### Install dependencies (AWS, Terraform, Kubectl)

```sh
./install.sh
```

### Terraform Apply

* Update defaults in `./variables.tf`

### Connect KubeCTL

* `aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks`