# ------------------------------------------------------------------------------
# This script is used to install docker on the different actors of the cluster
# It is for Ubuntu 18.04
# Expectation: we start from a cleaned VM
#
# Authors: benoit.vianin@sinabe.ch and valery.jacot@innosmart.io
# ------------------------------------------------------------------------------

# This script is built based on Docker official documentation:
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

# Update the apt package index
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install the Docker engine

# Update the apt package index
sudo apt-get update

# Install the latest version of Docker Engine - Community and containerd, or go to the next 
# step to install a specific version
sudo apt-get install docker-ce docker-ce-cli containerd.io

# End of the script
# Potential improvements:
# -> Verify that the key has been correctly added
# -> Vefify automatically that Docker has correctly been installed