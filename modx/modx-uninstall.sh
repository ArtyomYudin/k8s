#!/bin/bash

export NAMESPACE=$1
export SITE_NAME=$2
export DOMAIN=$3
export ALB_IP_ADDRESS=$4


envsubst <  security/rbac.yaml | kubectl delete -f -
envsubst <  security/modx-secret.yaml | kubectl delete -f -
envsubst <  deployments/nginx-deployment.yaml | kubectl delete -f -
kubectl -n $NAMESPACE delete configmap masterutm-cert
envsubst <  deployments/php-fpm-deployment.yaml | kubectl delete -f -
envsubst <  services/php-fpm-service.yaml | kubectl delete -f -
envsubst <  services/nginx-service.yaml | kubectl delete -f -

if [[ $# -gt 0  && "$5" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    envsubst <  persistentvolumeclaim/modx-pvc.yaml | kubectl delete -f -
    kubectl delete namespace $NAMESPACE
fi