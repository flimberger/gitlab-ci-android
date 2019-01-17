DOCKER?=	docker

USER =		flimberger
CONTAINER =	gitlab-ci-android
VERSION =	latest

CONTAINER_FULL =	${USER}/${CONTAINER}:${VERSION}
SRCDIR =		${.CURDIR}/..

all: build
.PHONY: all

build:
	${DOCKER} build --tag ${CONTAINER} ${.CURDIR}
.PHONY: build

run: build
	${DOCKER} run -it \
	    --mount type=bind,source="${SRCDIR}",target=/src \
	    --cap-add SYS_PTRACE \
	    ${CONTAINER} /bin/bash
.PHONY: run

tag: build
	${DOCKER} tag ${CONTAINER} ${CONTAINER_FULL}
.PHONY: tag

publish: tag
	${DOCKER} push ${CONTAINER_FULL}
.PHONY: publish
