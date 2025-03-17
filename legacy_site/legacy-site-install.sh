#!/bin/sh

export BRANCH_NAME=$1
export BRANCH_ID=$2

envsubst < namespace/legacy-site-namespace.yaml | kubectl apply -f -
envsubst < security/rbac.yaml | kubectl apply -f -
#envsubst < security/legacy-site-secret.yaml | kubectl apply -f -
envsubst < persistentvolumeclaim/legacy-site-pvc.yaml | kubectl apply -f -
envsubst < deployments/php-fpm-deployment.yaml | kubectl apply -f -
envsubst < deployments/nginx-deployment.yaml | kubectl apply -f -
envsubst < services/php-fpm-service.yaml | kubectl apply -f -
envsubst < services/nginx-service.yaml | kubectl apply -f -