#!/usr/bin/env bash

source $PWD/scripts/common.sh

set -e

# Ensure that we are using our cluster
kubectl config use-context "$KUBECTL_CONTEXT"

echo "Deploying application..."

helm upgrade "$DEPLOYMENT_NAME" "$PWD/$SERVICE_NAME" \
    --install \
    --values "$PWD"/"$SERVICE_NAME"/secret.yaml
