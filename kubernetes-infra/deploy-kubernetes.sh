#!/bin/bash

AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r) envsubst < kubernetes-infra/app.template.yaml > kubernetes-infra/app.yaml

kubectl apply -f kubernetes-infra/app.yaml