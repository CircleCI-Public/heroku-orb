#!/bin/bash

CIRCLE_TOKEN_FETCHED=$(eval echo "${PARAM_CIRCLE_TOKEN}")
HEROKU_KEY_FETCHED=$(eval echo "${PARAM_HEROKU_KEY}")

if [ -z "$CIRCLE_TOKEN_FETCHED" ]; then
  echo "CircleCI token is not set"
  exit 1
fi
if [ -z "$HEROKU_KEY_FETCHED" ]; then
  echo "Heroku API key is not set"
  exit 1
fi

function get_artifacts {
  artifact_res_tmpfile=$(mktemp)
  artifact_request=$(curl -s -o "${artifact_res_tmpfile}" -w "%{http_code}" --retry 5 \
      --url "https://circleci.com/api/v2/project/gh/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/${CIRCLE_BUILD_NUM}/artifacts" \
      --header "Circle-Token: ${CIRCLE_TOKEN_FETCHED}")
  artifact_results=$(cat "${artifact_res_tmpfile}")
  if [ "${artifact_request}" != "200" ]; then
    echo "Error fetching artifacts"
    echo
    echo "$artifact_results"
    exit 1
  fi

  for row in $(echo "${artifact_results}" | jq -c '.items[]'); do
    _jq() {
     echo "${row}" | jq -r "${1}"
    }
    # shellcheck disable=SC2053
    if [[ $(_jq '.path') == $PARAM_ARTIFACT_PATTERN ]]; then
      ARTIFACT_LOCATION=$(_jq '.url')
      echo "Using ${ARTIFACT_LOCATION} as artifact."
      return 0
    fi
    echo "No artifacts found!"
    echo
    echo "$artifact_results"
    return 1
  done
}

function create {
  heroku_request=$(curl -n -X POST 'https://api.heroku.com/review-apps' \
    -d "{
      \"branch\": \"${CIRCLE_BRANCH}\",
      \"pipeline\": \"${HEROKU_PIPELINE}\",
      \"source_blob\": {
        \"url\": \"${ARTIFACT_LOCATION}?circle-token=${CIRCLE_TOKEN_FETCHED}\",
        \"version\": \"${CIRCLE_SHA1}\"
      }
    }" \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.heroku+json; version=3" \
    -H "Authorization: Bearer ${HEROKU_KEY_FETCHED}")

  echo "$heroku_request" | jq -C
}

get_artifacts
create
