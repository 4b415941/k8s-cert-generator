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

# Generate SSL certificates with secure file permissions
openssl genrsa -out "$CERT_DIR/${USER}.key" 2048
chmod 600 "$CERT_DIR/${USER}.key"

openssl req -new -key "$CERT_DIR/${USER}.key" -out "$CERT_DIR/${USER}.csr" -subj "/CN=${USER}/O=${GROUP}"

openssl x509 -req -in "$CERT_DIR/${USER}.csr" -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out "$CERT_DIR/${USER}.crt" -days 500
chmod 600 "$CERT_DIR/${USER}.crt"
