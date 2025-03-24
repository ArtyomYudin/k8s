#!/bin/sh

export NAMESPACE=$1
export ROOT_PASSWORD=$2

envsubst < security/rbac.yaml | kubectl delete -f -
envsubst < security/mariadb-secret.yaml | kubectl delete -f -
envsubst < statefulset/mariadb-statefulset.yaml | kubectl delete -f -
envsubst < services/mariadb-service.yaml | kubectl delete -f -

if [[ $# -gt 0  && "$1" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    envsubst < persistentvolumeclaim/mariadb-pvc.yaml | kubectl delete -f -
    kubectl delete namespace $NAMESPACE
fi