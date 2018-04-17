#!/usr/bin/make
#
all: run
VERSION=`cat version.txt`
#BUILD_NUMBER := debug1
UID := $(shell id -u)
PROJECTID := $(shell basename "${PWD}")

buildout.cfg:
    ln -fs dev.cfg buildout.cfg

.env:
    echo uid=${UID} > .env
    echo projectid=${PROJECTID} >> .env

build: .env
    docker-compose build

up:
    docker-compose up

bootstrap:
    ./bootstrap.sh
