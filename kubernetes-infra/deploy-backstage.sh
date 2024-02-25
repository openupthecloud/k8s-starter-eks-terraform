#!/bin/bash

kubectl apply -f kubernetes-infra/backstage-app.yaml
kubectl apply -f kubernetes-infra/backstage-db.yaml