#!/bin/bash

PARAM_HEROKU_API_KEY="${!PARAM_HEROKU_API_KEY}"

if [ "$PARAM_RECURSIVE" == "1" ];then
  set -- "$@" --resursive
fi

heroku container:push -a "$PARAM_APP_NAME" "$@" "$PARAM_PROCESS_TYPES"