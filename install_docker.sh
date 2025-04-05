# First let's update all the packages to the latest ones with the following command
sudo apt update -qq

# Now we want to install some prerequisite packages which will let us use HTTPS over apt
sudo apt install apt-transport-https ca-certificates curl software-properties-common -qq

# After that we will add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# We will add the Docker repository to our APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Next let's update the package database with our newly added Docker package repo
sudo apt update -qq

# Finally lets install docker with the below command
sudo apt install docker-ce

# Lets check that docker is running
docker