DOCKER_IMAGE=$(notdir $(CURDIR))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
USERNAME=$(shell whoami)

DOCKER := podman
DOCKER_RUN_OPTS = \
	-h $(notdir $(CURDIR)) \
	--userns=keep-id \
	-v $(CURDIR):$(CURDIR):Z \
	-v $(CURDIR)/.git:$(CURDIR)/.git:ro,Z \
	-e GIT_OPTIONAL_LOCKS=0 \
	-w $(CURDIR) \
	--rm

.PHONY: all bash build clean dialyzer doc image shell test gemini

all: build

image:
	$(DOCKER) build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) --build-arg USERNAME=$(USERNAME) -t $(DOCKER_IMAGE) .

bash:
	$(DOCKER) run $(DOCKER_RUN_OPTS) \
		$(X11_OPTS) \
		-ti \
		$(DOCKER_IMAGE) \
		bash

codex:
	mkdir -p $(HOME)/.codex
	$(DOCKER) run $(DOCKER_RUN_OPTS) \
		-v $(HOME)/.codex:/home/$(USERNAME)/.codex:Z \
		-e HOME=/home/$(USERNAME) \
		-it \
		$(DOCKER_IMAGE) \
		codex --yolo
