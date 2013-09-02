#!/bin/sh
set -e

version="0.5b"

die() {
	echo $1
	exit 1
}

echo "Installing ByzPi $version"

echo "Adding our repository and apt-signing key."
curl -s -o byzantium.key http://byzantium.github.io/ByzPi/public.key || die "Failed to download key."
sudo apt-key add byzantium.key || die "Failed to install key."
rm -f byzantium.key
echo "deb http://byzantium.github.io/ByzPi/apt/ wheezy main contrib" | sudo tee /etc/apt/sources.list.d/byzantium.list

echo "Updating apt's cache."
sudo apt-get -q update || die "Failed to update apt's cache!"

echo "Installing git."
sudo apt-get -qy install git || die "Failed to install git!"

echo "Installing puppet."
sudo apt-get -qy install puppet || die "Failed to install puppet!"

echo "Checking out the ByzPi repo."
if [ -d ByzPi ]; then
    echo "ByzPi repo exists.  Updating it just in case."
    cd ByzPi
	git checkout $version
    git pull || die "Failed to update the ByzPi repo!"
    cd ..
else
    echo "Cloning ByzPi repo."
    git clone -b $version git://github.com/Byzantium/ByzPi.git || die "Failed to checkout the ByzPi repo!"
fi

echo "Installing the ByzPi puppet module."
sudo ln -sf "$(pwd)/ByzPi/puppet-etc/modules/byzpi/" /etc/puppet/modules/byzpi

echo "Applying the ByzPi configuration."
sudo puppet apply -e "include byzpi" || die "Applying the byzpi configuration failed."

echo "Installation complete! Restart your Raspberry Pi with the 'reboot' command to continue."

