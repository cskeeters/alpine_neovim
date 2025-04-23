ENGINE=docker
IMAGE=alpine_neovim
APP_NAME=DELETE

build: dotvim.tgz
	$(ENGINE) build -t $(IMAGE) --pull .

bash:
	$(ENGINE) run -it --rm --name $(APP_NAME) $(IMAGE) /bin/bash

dotvim.tgz:
	bash make_dotvim.sh
