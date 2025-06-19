#!/bin/bash

export NAMESPACE=$1
export SITE_NAME=$2
export DOMAIN=$3



envsubst <  security/rbac.yaml | kubectl delete -f -
envsubst <  security/modx-secret.yaml | kubectl delete -f -
envsubst <  deployments/nginx-deployment.yaml | kubectl delete -f -
envsubst <  deployments/php-fpm-deployment.yaml | kubectl delete -f -
envsubst <  services/php-fpm-service.yaml | kubectl delete -f -
envsubst <  services/nginx-service.yaml | kubectl delete -f -

if [[ $# -gt 0  && "$2" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    envsubst <  persistentvolumeclaim/modx-pvc.yaml | kubectl delete -f -
    kubectl delete namespace $SITE_NAME
fi