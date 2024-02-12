docker_compose("./docker-compose.yml")
docker_build('microservice-a', './microservice-a')
docker_build('microservice-b', './microservice-b')

allow_k8s_contexts('arn:aws:eks:us-east-1:262559753791:cluster/my-cluster-eks')
docker_build('262559753791.dkr.ecr.us-east-1.amazonaws.com/microservice-a', './microservice-a')
docker_build('262559753791.dkr.ecr.us-east-1.amazonaws.com/microservice-b', './microservice-b')
k8s_yaml('app.yaml')