#!/usr/bin/env bash

source $PWD/scripts/common.sh

set -e

# Ensure that we are using our cluster
kubectl config use-context "$KUBECTL_CONTEXT"

echo "Updating dependencies..."

helm dependency update "$PWD/$SERVICE_NAME"

echo "Deploying application..."

helm upgrade "$DEPLOYMENT_NAME" "$PWD/$SERVICE_NAME" \
    --install

# echo "Waiting for traefik pod to be ready..."

# # Wait for the ingress to become available
# kubectl wait \
#     --for=condition=ready pod \
#     --selector=app.kubernetes.io/name=traefik \
#     --timeout=2m

# kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
