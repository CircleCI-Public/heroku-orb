#!/bin/bash

if ! command -v heroku &> /dev/null; then
  curl https://cli-assets.heroku.com/install.sh | sh
else
  echo "Heroku is already installed. No operation was performed."
fi