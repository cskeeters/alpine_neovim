ENGINE=docker
IMAGE=alpine_neovim
APP_NAME=DELETE
RUN_FLAGS=-it --rm

build: dotvim.tgz
	$(ENGINE) build -t $(IMAGE) .

bash:
	$(ENGINE) run $(RUN_FLAGS) --name $(APP_NAME) $(IMAGE) /bin/bash

dotvim.tgz:
	bash make_dotvim.sh
