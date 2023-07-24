#!/bin/bash

for volume in "/Volumes"/*

do
	volumeInfo=$(diskutil info "$volume")
	volumeName=$(grep "Volume Name" <<< "$volumeInfo" | cut -d ':' -f2 | sed -e 's/^[[:space:]]*//')
	volumeType=$(grep "Type (Bundle):" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')
	deviceNode=$(grep "Device Node:" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')

	if [[ $volumeType == 'ntfs' ]]; then
		sudo umount "/Volumes/$volumeName"
		diskutil mount "$volumeName"
#		sudo /usr/local/sbin/mount_ntfs "$deviceNode" "/Volumes/$volumeName"
	fi
done