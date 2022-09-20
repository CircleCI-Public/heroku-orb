#!/bin/bash

PARAM_APP_NAME=$(eval echo "${PARAM_APP_NAME}")
PARAM_HEROKU_API_KEY=${!PARAM_HEROKU_API_KEY}

if [ "$PARAM_FORCE_PUSH" == "1" ];then
  force="-f"
fi


heroku_url="https://heroku:${PARAM_HEROKU_API_KEY}@git.heroku.com/${PARAM_APP_NAME}.git"

if [ -n "$PARAM_DEPLOY_BRANCH" ]; then
  git push $force "$heroku_url" "$PARAM_DEPLOY_BRANCH:main"
elif [ -n "$PARAM_DEPLOY_TAG" ]; then
  git push $force "$heroku_url" "${PARAM_DEPLOY_TAG}^{}:main"
else
  echo "No branch or tag found."
  exit 1
fi