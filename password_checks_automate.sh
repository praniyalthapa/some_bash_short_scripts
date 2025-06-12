#!/bin/bash
user=praniyalnotexit
if grep $user /etc/passwd
then
	echo "the user $user account exit in passwd folder"

else
	echo "the user $user account does not exit in passwd folder"
if ls -d /home/$user/
then
	echo "But $user has a active directory in the folder remained"

fi
fi

