#!/bin/bash

if [[ $HEROKU_API_KEY == "" ]]; then
  echo "No Heroku API key set, please set the HEROKU_API_KEY environment variable."
  echo "This can be found by running the $(heroku auth:token) command locally."
  exit 1
else
  echo "Heroku API key found."
fi
