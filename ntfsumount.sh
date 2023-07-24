#!/bin/bash
#---- ---- ---- ----
# Install osxfuse and ntfs-3g via brew
# $ brew cask install osxfuse
# $ brew install ntfs-3g
# Run following in case of any issue
# $ brew link --overwrite ntfs-3g
# Install ntfsmount script
# $ curl -Lo /usr/local/bin/ntfsmount;chmod +x /usr/local/bin/ntfsmount
# $ curl -Lo /usr/local/bin/ntfsumount;chmod +x /usr/local/bin/ntfsumount
# Ref: https://github.com/osxfuse/osxfuse/wiki/NTFS-3G
#---- ---- ---- ----

for volume in "/Volumes"/*

do
	volumeInfo=$(diskutil info "$volume")
	volumeName=$(grep "Volume Name" <<< "$volumeInfo" | cut -d ':' -f2 | sed -e 's/^[[:space:]]*//')
	volumeType=$(grep "Type (Bundle):" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')
	deviceNode=$(grep "Device Node:" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')

	if [[ $volumeType == 'ntfs' ]]; then
		echo "------------------------------------------"
		diskutil umount "$deviceNode";diskutil mount "$deviceNode"
#		sudo /usr/local/sbin/mount_ntfs "$deviceNode" "/Volumes/$volumeName"
	fi
done