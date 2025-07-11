#!/bin/sh

export NAMESPACE=$1
export SITE_NAME=$2
export DOMAIN=$3
export ALB_IP_ADDRESS=$4

envsubst < namespace/modx-namespace.yaml | kubectl apply -f -
envsubst < security/rbac.yaml | kubectl apply -f -
envsubst < security/modx-secret.yaml | kubectl apply -f -
envsubst < persistentvolumeclaim/modx-pvc.yaml | kubectl apply -f -
envsubst < deployments/php-fpm-deployment.yaml | kubectl apply -f -
kubectl -n $NAMESPACE create configmap masterutm-cert \
        --from-file=server.key=/Volumes/Macintosh\ HD\ Dev/legacy-site/masterutm.ru-cert/masterutm.ru.key \
        --from-file=server.crt=/Volumes/Macintosh\ HD\ Dev/legacy-site/masterutm.ru-cert/masterutm.ru-chain.cert
envsubst < deployments/nginx-deployment.yaml | kubectl apply -f -
envsubst < services/php-fpm-service.yaml | kubectl apply -f -
envsubst < services/nginx-service.yaml | kubectl apply -f -