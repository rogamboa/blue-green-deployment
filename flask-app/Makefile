SHELL = /bin/bash

setup:
	# Create python virtualenv
	python3 -m venv ./.devops

install:
	# This should be run from inside a virtualenv
	pip3 install --upgrade pip && \
	pip3 install -r requirements.txt
	pip3 install pylint
	wget -O ./hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && \
	chmod +x ./hadolint

lint:
	# This should be run from inside a virtualenv
	pylint app.py
	./hadolint Dockerfile

all: install lint
