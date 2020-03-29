NAME = homedir

all: build tag push

build:
	docker build --compress -t $(NAME) .

tag:
	docker tag homedir savonarola/homedir

push:
	docker push savonarola/$(NAME)

install:
	./install.pl

install-remote:
	./install_remote.sh $(HOST)
