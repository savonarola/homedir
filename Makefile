NAME = homedir

.PHONY: all
all: build tag push

.PHONY: build
build:
	docker build --compress -t $(NAME) .

.PHONY: tag
tag:
	docker tag homedir savonarola/homedir

.PHONY: push
push:
	docker push savonarola/$(NAME)

.PHONY: install
install:
	./install.pl

