#!/usr/bin/make
all: run
UID := $(shell id -u)
PROJECTID := $(shell basename "${PWD}")

buildoutcfg:
	ln -fs dev.cfg buildout.cfg

.env:
	echo uid=${UID} > .env
	echo projectid=${PROJECTID} >> .env

src:
	mkdir src

build: .env src
	rm -rf parts
	docker-compose build --pull # <--no-cache
	# fullfil src folder
	# check if src folder is empty
	make buildout

buildout:
	docker-compose run --rm instance bin/buildout
	# docker-compose run --rm instance bin/develop checkout .
	# docker-compose run --rm instance /home/imio/intranet/bin/develop up

up:
	docker-compose run --rm --service-ports instance fg

bash:
	docker-compose run --rm --service-ports instance bash

bootstrap: buildoutcfg
	./bootstrap.sh

docker-image:
	docker build --no-cache --pull -t docker-staging.imio.be/intranet/imio:latest .

clean:
	docker-compose down
	rm -fr develop-eggs downloads eggs parts .installed.cfg lib include bin .mr.developer.cfg local/ share/
