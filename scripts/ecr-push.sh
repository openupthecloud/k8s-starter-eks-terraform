#/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(terraform output -raw ecr_repository_url_microservice_a)

docker-compose build
docker tag microservice-a $(terraform output -raw ecr_repository_url_microservice_a)
docker tag microservice-b $(terraform output -raw ecr_repository_url_microservice_b)
docker push $(terraform output -raw ecr_repository_url_microservice_a)
docker push $(terraform output -raw ecr_repository_url_microservice_b)