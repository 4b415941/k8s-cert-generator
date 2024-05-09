#!/usr/bin/env bash

set -euo pipefail

if [ -z "${1:-}" ]; then
    echo "You need to provide a username!"
    exit 1
fi

if [ -z "${2:-}" ]; then
    echo "You need to provide a group!"
    exit 1
fi

USER="$1"
GROUP="$2"

# Ensure secure directory for storing keys and certificates
CERT_DIR="~/certs"
mkdir -p "$CERT_DIR"
chmod 700 "$CERT_DIR"

# Generate SSL certificates
./create_k8s-user.sh "$USER" "$GROUP"

# Add user's certificate to Kubernetes for authentication
kubectl config set-credentials "$USER" --client-certificate="${CERT_DIR}/${USER}.crt" --client-key="${CERT_DIR}/${USER}.key"

# Create a new context and link user credentials to this context
kubectl config set-context "${USER}-context" --cluster=minikube --user="$USER"

# Update the default context
kubectl config use-context "${USER}-context"

echo "Credentials for user $USER configured successfully!"
