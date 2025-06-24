#!/bin/sh

export NAMESPACE=$1
export BRANCH_ID=$2
export BRANCH_DOMAIN=$3

#export BRANCH_NAME=$1
#export BRANCH_ID=$2

envsubst < namespace/branch-websites-namespace.yaml | kubectl apply -f -
envsubst < security/rbac.yaml | kubectl apply -f -
#envsubst < security/legacy-site-secret.yaml | kubectl apply -f -
envsubst < persistentvolumeclaim/branch-pvc.yaml | kubectl apply -f -
envsubst < deployments/php-fpm-deployment.yaml | kubectl apply -f -
kubectl -n $NAMESPACE create configmap centrinform-wildcard-cert --from-file=server.key=/Volumes/Macintosh\ HD\ Dev/wild\ 2025/key2025.pem --from-file=server.crt=/Volumes/Macintosh\ HD\ Dev/wild\ 2025/chain2025.pem
#envsubst < deployments/nginx-configmap.yaml | kubectl apply -f -
envsubst < deployments/nginx-deployment.yaml | kubectl apply -f -
envsubst < services/php-fpm-service.yaml | kubectl apply -f -
envsubst < services/nginx-service.yaml | kubectl apply -f -