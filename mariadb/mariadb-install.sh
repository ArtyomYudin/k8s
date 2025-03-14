#!/bin/sh


kubectl create namespace mariadb
kubectl label --overwrite ns mariadb pod-security.kubernetes.io/enforce=privileged
#kubectl create -n mariadb -f security/rbac.yaml
kubectl create -n mariadb -f security/mariadb-secret.yaml
kubectl create -n mariadb -f persistentvolumeclaim/mariadb-pvc.yaml
kubectl create -n mariadb -f statefulsets/mariadb-statefulset.yaml