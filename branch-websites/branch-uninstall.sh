#!/bin/bash

export BRANCH_NAME=$1
export BRANCH_ID=$2

envsubst <  security/rbac.yaml | kubectl delete -f -
#kubectl delete -f security/mariadb-secret.yaml
envsubst <  deployments/nginx-deployment.yaml | kubectl delete -f -
envsubst <  deployments/php-fpm-deployment.yaml | kubectl delete -f -
envsubst <  services/php-fpm-service.yaml | kubectl delete -f -
envsubst <  services/nginx-service.yaml | kubectl delete -f -

if [[ $# -gt 0  && "$3" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    envsubst <  persistentvolumeclaim/branche-pvc.yaml | kubectl delete -f -
    kubectl delete namespace $BRANCH_NAME
fi