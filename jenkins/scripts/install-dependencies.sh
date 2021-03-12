#!/usr/bin/env sh

echo "Creating virtual env and install dependencies"
python3 -m venv ./.devops
. ./.devops/bin/activate
cd ./flask-app
make install