NAME = m4ucorp/tools
RUBYVERSION = docker-rails.ruby-2.3.0
RAILS4VERSION = docker-rails.rails-4.2.5.1
RAILS5VERSION = docker-rails.rails-5.0.0

all: build-ruby build-rails4 build-rails5

build-ruby:
	docker build -t $(NAME):$(RUBYVERSION) --rm ruby

build-rails4:
	docker build -t $(NAME):$(RAILS4VERSION) --rm rails

build-rails5:
	docker build -t $(NAME):$(RAILS5VERSION) --rm rails-5.0.0

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

push-ruby:
	docker push $(NAME):$(RUBYVERSION)

push-rails4:
	docker push $(NAME):$(RAILS4VERSION)

push-rails5:
	docker push $(NAME):$(RAILS5VERSION)