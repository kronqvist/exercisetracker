DOCKER_IMAGE=$(notdir $(CURDIR))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
USERNAME=$(shell whoami)

DOCKER_RUN_OPTS = \
    -h $(notdir $(CURDIR)) \
    -u $(USER_ID):$(GROUP_ID) \
    -v $(CURDIR):$(CURDIR) \
    -w $(CURDIR) \
    --rm

GEMINI_API_KEY_FILE=$(HOME)/.gemini_api_key

.PHONY: all bash build clean dialyzer doc image shell test gemini

all: build

image:
	docker build --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) --build-arg USERNAME=$(USERNAME) -t $(DOCKER_IMAGE) .

bash:
	docker run $(DOCKER_RUN_OPTS) \
		$(X11_OPTS) \
		-ti \
		$(DOCKER_IMAGE) \
		bash

gemini:
	docker run $(DOCKER_RUN_OPTS) \
		--env GEMINI_API_KEY=$$(cat $(GEMINI_API_KEY_FILE)) \
		-v $(HOME)/.gemini:$(HOME)/.gemini \
		-it \
		$(DOCKER_IMAGE) \
		gemini

claude:
	docker run $(DOCKER_RUN_OPTS) \
		-v $(HOME)/.claude:$(HOME)/.claude \
		-v $(HOME)/.claude.json:$(HOME)/.claude.json \
		-it \
		$(DOCKER_IMAGE) \
		claude
