#!/bin/bash

PARAM_APP_NAME=$(eval echo "${PARAM_APP_NAME}")
PARAM_HEROKU_API_KEY=${!PARAM_HEROKU_API_KEY}
PARAM_DEPLOY_BRANCH=$(eval echo "${PARAM_DEPLOY_BRANCH}")

if [ "$PARAM_FORCE_PUSH" == "1" ];then
  force="-f"
fi

heroku_url="https://:${PARAM_HEROKU_API_KEY}@git.heroku.com/${PARAM_APP_NAME}.git"
echo "$heroku_url" > /tmp/orblog.txt

if [ -n "$PARAM_DEPLOY_BRANCH" ]; then
  git push $force "$heroku_url" "$PARAM_DEPLOY_BRANCH:main"
elif [ -n "$PARAM_DEPLOY_TAG" ]; then
  git push $force "$heroku_url" "${PARAM_DEPLOY_TAG}^{}:main"
else
  echo "No branch or tag found."
  exit 1
fi