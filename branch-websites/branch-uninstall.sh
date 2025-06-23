#!/bin/bash

export NAMESPACE=$1
export BRANCH_ID=$2
export BRANCH_DOMAIN=$3

envsubst <  security/rbac.yaml | kubectl delete -f -
envsubst <  deployments/nginx-deployment.yaml | kubectl delete -f -
#envsubst <  deployments/nginx-configmap.yaml | kubectl delete -f -
envsubst <  deployments/php-fpm-deployment.yaml | kubectl delete -f -
envsubst <  services/php-fpm-service.yaml | kubectl delete -f -
envsubst <  services/nginx-service.yaml | kubectl delete -f -

if [[ $# -gt 0  && "$4" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    envsubst < persistentvolumeclaim/branch-pvc.yaml | kubectl delete -f -
    kubectl delete namespace $NAMESPACE
fi