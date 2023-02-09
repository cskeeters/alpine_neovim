# alpine_neovim

This repository builds a docker image with [Alpine Linux](https://www.alpinelinux.org/) and [neovim](https://neovim.io/).

# Build

This will download the plugins identified with `Plug` in vimrc and then build the image based on the Dockerfile

    make


# Bash Shell

This will open a shell and allow you to test bash and vim settings.

    make bash
