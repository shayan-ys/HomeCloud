#!/usr/bin/env bash

source "$(pwd)"/scripts/common.sh

CLUSTER_NAME="$SERVICE_NAME"

set -e

if k3d cluster get | grep -q "$CLUSTER_NAME"; then
    echo "Cluster already exists... Skipping cluster creation."
else
    mkdir -p "$MOUNT_PATH/plex"
    mkdir -p "$MOUNT_PATH/dns/logs"

    # Startup our cluster
    k3d cluster create "$CLUSTER_NAME" \
        --config "$CLUSTER_CONFIG_FILE" \
        --volume "$MOUNT_PATH:/mnt/data"

    kubectl cluster-info --context "$KUBECTL_CONTEXT";

    # echo "Updating dependencies..."
    # helm repo update
    # helm dependency update "$PWD/$SERVICE_NAME"

    echo "Deploy ingress-nginx..."
    kubectl apply -f "https://github.com/kubernetes/ingress-nginx/blob/ed5aee7659bdd9a5f018ef56ddd2de664b2d96e7/deploy/static/provider/baremetal/deploy.yaml"

    while : ; do
      echo "Wait for the ingress-controller to become available"
      kubectl wait --namespace ingress-nginx \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=2m \
        && break

      echo "Ingress-controller not available trying again in 3 seconds"
      sleep 3
    done

    echo "Patch nginx controller"
    kubectl patch deployment ingress-nginx-controller \
      --namespace ingress-nginx \
      --patch "$(cat "$NGINX_PATCH")"
fi

source "$PWD"/scripts/deploy.sh
