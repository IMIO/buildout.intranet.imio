#!/usr/bin/make
all: run
UID := $(shell id -u)
PROJECTID := $(shell basename "${PWD}")

buildout.cfg:
	ln -fs dev.cfg buildout.cfg

.env:
	echo uid=${UID} > .env
	echo projectid=${PROJECTID} >> .env

src:
	mkdir src

build: .env src
	docker-compose build --pull # --no-cache

up:
	docker-compose up

bootstrap:
	./bootstrap.sh


docker-image:
	docker build --pull -t docker-staging.imio.be/intranet/imio:latest .
