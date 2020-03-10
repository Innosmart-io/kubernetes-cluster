# Purpose
This project is to evaluate how to deploy a mutli VM kubernetes cluster.  
It is the result of the collaboration between [Sinabe](https://sinabe.ch/) and [Innosmart](https://www.innosmart.io).  

Authors:
- [Benoit Vianin](benoit.vianin@sinabe.ch)
- [Valery Jacot](valery.jacot@innosmart.io)

# Kubernetes installation

On all VMs, avoid SWAP.
Either you don't create any when creating the VM, either you need to perform command:
```Bash
swapoff -a
```

## Structure of the repository

- **setup**: contains the different shell to execute on the different actors of the cluster

## Installation process
Follow the scripts steps on each of your VMs actor in the cluster.

```Bash
# Clone this repository on your VMs
git clone https://github.com/Innosmart-io/kubernetes-cluster.git
cd kubernetes-cluster/setup

# Install Docker - the container runtime. For this test we decided to use Docker.
bash docker.sh

# Install all the kube stuff
bash kubesetup.sh

```
This allow to have all the components available to start to setup your cluster.

## Set up the master

Connect to the VM which will be your master.  

Execute the following commands
```Bash
# Initaliation of the master - please note that a master needs at least to vCPU
kudeadm init

# WARNING: After this command, you will have a message telling you how
# to connect workers to your kube admin.
# Copy and backup the line which looks like:

# kubeadm join <IP_ADDRESS> --token <THE_TOKEN> \
#     --discovery-token-ca-cert-hash <THE_HASH>

# This line will the one to use to register workers to your master.

# Run those three commands as REGULAR USER
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Register workers
To register workers, ssh the different VMs and run the backuped command:

```Bash
kubeadm join <IP_ADDRESS> --token <THE_TOKEN> \
     --discovery-token-ca-cert-hash <THE_HASH>
```

## Test the cluster
Go back on the master; execute the command:

```Bash
# Running the command should have something like:
$ kubectl get nodes
NAME        STATUS     ROLES    AGE    VERSION
<vm1>       NotReady   master   35m    v1.17.3
<vm2>       NotReady   <none>   3m6s   v1.17.3
```

# Thoughts

## Docker vs CRI-O
Both seems to implement CRI; but CRI-O will always implement CRI and has been built to avoid too much dependencies to Docker.
Will see if we do a test with CRI-O in the near future.

## Security
Will install IPtable and set up security in a second phase