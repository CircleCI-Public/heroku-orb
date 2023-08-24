#!/bin/bash

PARAM_HEROKU_API_KEY="${!PARAM_HEROKU_API_KEY}"

if [ "$PARAM_RECURSIVE" == "1" ];then
  set -- "$@" --resursive
fi

if [ -n $PARAM_CONTEXT_PATH ];then
  set -- "$@" "--context-path $PARAM_CONTEXT_PATH"
fi

set -x
heroku container:push -a "$PARAM_APP_NAME" "$@" "$PARAM_PROCESS_TYPES"
set +x