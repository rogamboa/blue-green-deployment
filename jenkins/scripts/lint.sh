#!/usr/bin/env sh

echo "Running lint step on app.py file"
. ./.devops/bin/activate
cd ./flask-app
make lint