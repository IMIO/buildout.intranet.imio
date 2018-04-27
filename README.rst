buildout.intranet.imio
======================

Intro
-----
This repo is used to build imio intranet


Install docker and docker-compose
---------------------------------
docker:
https://docs.docker.com/install/linux/docker-ce/ubuntu/

docker-compose:
https://docs.docker.com/compose/install/

check if your user is in docker group, use command::

    $ groups

if docker is in list, you can skip this::

    $ sudo usermod -aG docker $USER

And after, restart your session


Dev
---
After docker(-compose) installation, you can start developing with cloning repo::

    git clone git@github.com:IMIO/buildout.intranet.imio.git && cd buildout.intranet.imio

Now you can build image, and start instance::

    make build

    make up

`make build` is going to build image with buildout.
`make up` will start instance.


Get data from prod
------------------
If you would like to get data from prod, start this command::

    $ ./rsync.sh

! You have to add your ssh public key into imio user on intranet server (`cat ~/.ssh/id_rsa.pub`)
