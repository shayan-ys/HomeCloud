#!/usr/bin/env bash

source $PWD/scripts/common.sh

set -e

NAMESPACE="cert-manager"

echo "Installing cert-manager Helm chart..."

helm install cert-manager jetstack/cert-manager \
  --namespace $NAMESPACE \
  --create-namespace \
  --version v1.3.0 \
  --set installCRDs=true

echo "Waiting for cer-manager webhook to be ready"

kubectl rollout status deployment $NAMESPACE-webhook \
  --namespace $NAMESPACE
