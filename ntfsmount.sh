#!/bin/bash
#---- ---- ---- ----
# Copyright (C) Naing Ye Minn <naingyeminn@gmail.com>
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#---- ---- ---- ----
# Install osxfuse and ntfs-3g via brew
# $ brew cask install osxfuse
# $ brew install ntfs-3g
# Run following in case of any issue
# $ brew link --overwrite ntfs-3g
# Install ntfsmount script
# $ curl -Lo /usr/local/bin/ntfsmount http://tiny.cc/ntfsmount
# $ chmod +x /usr/local/bin/ntfsmount
# Ref: https://github.com/osxfuse/osxfuse/wiki/NTFS-3G
#---- ---- ---- ----

for volume in "/Volumes"/*

do
	volumeInfo=$(diskutil info "$volume")
	volumeName=$(grep "Volume Name" <<< "$volumeInfo" | cut -d ':' -f2 | sed -e 's/^[[:space:]]*//')
	volumeType=$(grep "Type (Bundle):" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')
	deviceNode=$(grep "Device Node:" <<< "$volumeInfo" | cut -d ':' -f2 | tr -d ' ')

	if [[ $volumeType == 'ntfs' ]]; then
#		sudo mount "$deviceNode" "/Volumes/$volumeName"
		sudo umount "/Volumes/$volumeName"
#		sudo /usr/local/sbin/mount_ntfs "$deviceNode" "/Volumes/$volumeName"
		sudo /usr/local/bin/ntfs-3g "$deviceNode" "/Volumes/$volumeName" -o local -o allow_other -o auto_xattr -o volname="$volumeName"
	fi
done