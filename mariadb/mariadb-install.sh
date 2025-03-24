#!/bin/sh

export NAMESPACE=$1
export ROOT_PASSWORD=$2

envsubst < namespace/mariadb-namespace.yaml | kubectl apply -f -
envsubst < security/rbac.yaml | kubectl apply -f -
envsubst < security/mariadb-secret.yaml | kubectl apply -f -
envsubst < persistentvolumeclaim/mariadb-pvc.yaml | kubectl apply -f -
envsubst < statefulset/mariadb-statefulset.yaml | kubectl apply -f -
envsubst < services/mariadb-service.yaml | kubectl apply -f -
