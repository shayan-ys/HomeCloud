#!/usr/bin/env bash

PWD=$(pwd)
export PWD
export BUILD_VERSION="0.1.0"
export SERVICE_NAME="homecloud"
export DEPLOYMENT_NAME="homecloud"
export PROVIDER="k3d"
export KUBECTL_CONTEXT="$PROVIDER-$SERVICE_NAME"
export MOUNT_PATH="$PWD/cluster/mount"
export CLUSTER_CONFIG_FILE="$PWD/cluster/cluster.yaml"
export NGINX_DEPLOYMENT="$PWD/nginx/ingress-nginx-baremetal-deploy.yaml"
export NGINX_PATCH="$PWD/nginx/patch.yaml"
