#!/bin/bash

heroku container:release -a "$PARAM_APP_NAME" "$PARAM_PROCESS_TYPES"