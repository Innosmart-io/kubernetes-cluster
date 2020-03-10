# ------------------------------------------------------------------------------
# This script is used to install kubelet, kubeadm and kubectl
# It is for Ubuntu 18.04
# Expectation: we start from a cleaned VM
#
# Authors: benoit.vianin@sinabe.ch and valery.jacot@innosmart.io
# ------------------------------------------------------------------------------

# Reference:
# https://kubernetes.io/docs/setup/production-environment/container-runtimes/
# and https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# Get the key for Kubernetes from Google repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add repo in APT
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update and install
sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl

# Block updates for Kubelet, Kubeadm and Kubectl 
sudo apt-mark hold kubelet kubeadm kubectl
