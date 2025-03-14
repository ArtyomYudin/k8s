#!/bin/bash

kubectl delete -n mariadb -f security/rbac.yaml
kubectl delete -n mariadb -f security/mariadb-secret.yaml
kubectl delete -n mariadb -f statefulsets/mariadb-deployment.yaml

if [[ $# -gt 0  && "$1" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    kubectl delete -n mariadb -f persistentvolumeclaim/mariadb-pvc.yaml
    kubectl delete namespace mariadb
fi