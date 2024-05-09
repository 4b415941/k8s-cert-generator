# k8s-cert-generator

These Bash scripts automate the process of generating SSL certificates and configuring Kubernetes credentials for users. They are designed to simplify the authentication setup process for users accessing a Kubernetes cluster.

## Features

- **Certificate Generation**: Automatically generates SSL certificates for Kubernetes users, including private keys and certificates signed by the minikube CA.
- **Credential Configuration**: Configures Kubernetes credentials for users, including setting client certificates and keys, creating new contexts, and updating the default context.
- **Security Measures**: Implements security measures such as ensuring secure file permissions and using encrypted keys.

## Prerequisites

- [minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- OpenSSL

## Usage

1. Clone this repository:

```bash
git clone https://github.com/4b415941/k8s-cert-generator.git
```

2. Navigate to the cloned directory:

```bash
cd k8s-cert-generator
```

3. Execute the k8s_user_auth.sh script to configure credentials for a user:

```bash
./k8s_user_auth.sh <username> <group>
```
