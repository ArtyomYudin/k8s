#!/bin/bash

kubectl delete -n mariadb -f security/rbac.yaml
kubectl delete -f security/mariadb-secret.yaml
kubectl delete -f statefulset/mariadb-statefulset.yaml
kubectl delete -f services/mariadb-service.yaml

if [[ $# -gt 0  && "$1" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    kubectl delete -f persistentvolumeclaim/mariadb-pvc.yaml
    kubectl delete namespace mariadb
fi