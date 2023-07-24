# MountNTFS
shell script mount disk internal partition 

# Need a support library
$ brew install macfuse
$ brew install ntfs-3g-mac

# Give access to run
$ chmod 777 ntfsmount.sh
$ chmod 777 ntfsumount.sh

# Run
$ ./ntfsmount.sh (read and write access )
$ ./ntfsumount.sh (read only access )
