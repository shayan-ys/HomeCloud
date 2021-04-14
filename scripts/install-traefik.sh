#!/usr/bin/env bash

source $PWD/scripts/common.sh

set -e

NAMESPACE="traefik"

kubectl create namespace $NAMESPACE

echo "Installing $NAMESPACE helm chart..."

helm install traefik traefik/traefik \
  --namespace $NAMESPACE \
  --values $PWD/traefik/values.yaml

echo "Waiting for $NAMESPACE to be ready"

kubectl rollout status deployment $NAMESPACE \
  --namespace $NAMESPACE
