
Install dependencies (AWS, Terraform, Kubectl)

```sh
./install.sh
```

Apply terraform for cluster

**Note:** Don't use us-east-1.

```
terraform apply \
    -var "vpc_id=vpc-090619aaca8c260f7" \
    -var "subnet_1=subnet-036bd8b3c2dfa5c5d" \
    -var "subnet_2=subnet-085a33f224585b87d" \
    -var "subnet_3=subnet-0c689224a7ee1fd1a" 
```