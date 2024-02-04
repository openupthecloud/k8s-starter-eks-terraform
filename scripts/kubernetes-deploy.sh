#/bin/bash

aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks

helm install app-chart ./app-chart --set microservice_a=$(terraform output -raw ecr_repository_url_microservice_a) --set microservice_b=$(terraform output -raw ecr_repository_url_microservice_b) 