#!/usr/bin/make
# UID := $(shell id -u)
# docker build args to add after tests: --no-cache --force-rm
docker-cache-image:
	docker build --no-cache --force-rm --pull --build-arg repo=buildout.intranet.imio --build-arg cmd='make bootstrap' -t docker-staging.imio.be/intranet/cache:latest .
