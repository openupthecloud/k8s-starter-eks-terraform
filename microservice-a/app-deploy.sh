#!/bin/bash
docker-compose build
docker tag microservice-a $(terraform -chdir=kubernetes-infra output -raw ecr_repository_url_microservice_a)
docker push $(terraform -chdir=kubernetes-infra output -raw ecr_repository_url_microservice_a)