#!/usr/bin/env bash

source $(pwd)/scripts/common.sh

CLUSTER_NAME="$SERVICE_NAME"

set -e

if k3d cluster get | grep -q "$CLUSTER_NAME"; then
    echo "Cluster already exists... Skipping cluster creation."
else
    mkdir -p "$MOUNT_PATH/plex"
    mkdir -p "$MOUNT_PATH/dns/logs"

    # Startup our cluster
    k3d cluster create $CLUSTER_NAME \
        --config "$CLUSTER_CONFIG_FILE" \
        --volume "$MOUNT_PATH:/mnt/data"

    kubectl cluster-info --context "$KUBECTL_CONTEXT";
fi

source $PWD/scripts/deploy.sh
