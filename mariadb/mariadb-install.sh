#!/bin/sh

kubectl apply -f namespace/mariadb-namespace.yaml
kubectl apply -f security/rbac.yaml
kubectl apply -f security/mariadb-secret.yaml
kubectl apply -f persistentvolumeclaim/mariadb-pvc.yaml
kubectl apply -f statefulset/mariadb-statefulset.yaml
kubectl apply -f services/mariadb-service.yaml