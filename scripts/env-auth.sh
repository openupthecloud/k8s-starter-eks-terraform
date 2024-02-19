#!/bin/bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(terraform -chdir=kubernetes-infra output -raw ecr_repository_url_microservice_a)

aws eks update-kubeconfig --region us-east-1 --name my-cluster-eks