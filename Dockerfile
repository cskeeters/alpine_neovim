FROM alpine:3.17.1
RUN apk add --no-cache bash neovim python3 py3-pip ctags git mercurial fzf the_silver_searcher

WORKDIR "/opt"
RUN git clone https://github.com/chriskempson/base16-shell

# explode plugins
ADD dotvim.tgz /root/

# neovim from pip3 is required for python3 vim plugins (ultisnips)
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip3 install wheel
RUN pip3 install neovim

ADD bashrc /root/.bashrc
ADD inputrc /root/.inputrc

ADD vimrc /root/.vimrc
RUN mkdir -p /root/.config/nvim
ADD init.vim /root/.config/nvim/

WORKDIR "/root"
CMD ["/bin/bash"]

# TODO configure fzf
