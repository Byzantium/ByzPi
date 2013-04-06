#!/bin/sh
set -e

die() {
	echo $1
	exit 1
}

echo "Adding the ByzPi repository to your apt sources."
echo "deb http://byzantium.github.com/ByzPi/apt wheezy main" | sudo tee /etc/apt/sources.list.d/byzpi.list

echo "Updating apt's cache."
sudo apt-get -q update || die "Failed to update apt's cache!"

echo "Installing git."
sudo apt-get -qy install git || die "Failed to install git!"

echo "Installing puppet."
sudo apt-get -qy install puppet || die "Failed to install puppet!"

echo "Checking out the ByzPi repo."
git clone git://github.com/Byzantium/ByzPi.git || die "Failed to checkout the ByzPi repo!"

echo "Installing the byzpi puppet module."
sudo ln -sf "$(pwd)/ByzPi/puppet-etc/modules/byzpi/" /etc/puppet/modules/byzpi

echo "Applying the byzpi configuration."
sudo puppet apply -e "include byzpi" || die "Applying the byzpi configuration failed."

echo "Installation complete! Restart your Raspberry Pi with the 'reboot' command to continue."

