#!/bin/bash

aws configure
terraform -chdir=kubernetes-infra init
terraform -chdir=kubernetes-infra apply 