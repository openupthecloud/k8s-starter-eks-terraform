#!/bin/bash
docker-compose build
docker tag microservice-b $(terraform -chdir=kubernetes-infra output -raw ecr_repository_url_microservice_b)
docker push $(terraform -chdir=kubernetes-infra output -raw ecr_repository_url_microservice_b)