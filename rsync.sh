#!/bin/sh
rsync -P imio@intranet-imio.imio.be:/srv/instances/intranet_imio/filestorage/Data.fs var/filestorage/Data.fs
echo 'blobstorage'
rsync -r --info=progress2 imio@intranet-imio.imio.be:/srv/instances/intranet_imio/blobstorage/ var/blobstorage/
