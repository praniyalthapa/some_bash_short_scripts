#!/bin/bash

echo "Checking for Red Hat package manager..."

# Check for rpm
if which rpm &> /dev/null; then
    item_rpm=1
    echo "You have the basic rpm utility"
else
    item_rpm=0
fi

# Check for dnf or yum
if which dnf &> /dev/null; then
    item_dnf=1
    echo "You have dnf package manager"
elif which yum &> /dev/null; then
    item_dnf=1
    echo "You have yum package manager"
else
    item_dnf=0
fi

# Check for flatpak
if which flatpak &> /dev/null; then
    item_flatpak=1
    echo "You have flatpak application container"
else
    item_flatpak=0
fi

# Calculate Red Hat score
rehatscore=$((item_rpm + item_dnf + item_flatpak))

echo
echo "Checking for Debian-based package manager..."

# Check for dpkg (corrected from 'dpgk')
if which dpkg &> /dev/null; then
    item_dpkg=1
    echo "You have basic dpkg utility"
else
    item_dpkg=0
fi

# Check for apt
if which apt &> /dev/null; then
    item_aptget=1
    echo "You have apt-get package"
else
    item_aptget=0
fi

# Check for snap
if which snap &> /dev/null; then
    item_snap=1
    echo "You have snap application container"
else
    item_snap=0
fi

# Calculate Debian score
debianscore=$((item_dpkg + item_aptget + item_snap))

# Final comparison
echo
if [ "$debianscore" -gt "$rehatscore" ]; then
    echo "You have a Debian-based Linux distribution."
else
    echo "You have a Red Hat-based Linux distribution."
fi
