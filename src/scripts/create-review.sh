#!/bin/bash
CIRCLE_PROJECT_USERNAME="gmemstr"
CIRCLE_PROJECT_REPONAME="circleci-koans"
CIRCLE_BUILD_NUM="936"
CIRCLE_API_KEY="47c67f9ab3a08d0cfe047afe881bba83d4aebf32"
ARTIFACT_PATTERN="*-2"
ARTIFACT_LOCATION=""

function get_artifacts {
  artifact_request=$(curl --request GET \
      --url "https://circleci.com/api/v2/project/gh/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/${CIRCLE_BUILD_NUM}/artifacts" \
      --header "Circle-Token: ${ARTIFACT_CIRCLE_TOKEN}")

  for row in $(echo "${artifact_request}" | jq -c '.items[]'); do
    _jq() {
     echo ${row} | jq -r ${1}
    }
    if [[ $(_jq '.path') == $ARTIFACT_PATTERN ]]; then
      ARTIFACT_LOCATION=$(_jq '.url')
      echo "Using ${ARTIFACT_LOCATION} as artifact."
      return 0
    fi
  done
}

function create {
  curl -n -X POST 'https://api.heroku.com/review-apps' \
  -d "{
    \"branch\": \"${CIRCLE_BRANCH}\",
    \"pipeline\": \"${HEROKU_PIPELINE}\",
    \"source_blob\": {
      \"url\": \"${ARTIFACT_LOCATION}?circle-token=${ARTIFACT_CIRCLE_TOKEN}\",
      \"version\": \"${CIRCLE_SHA1}\"
    }
  }" \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.heroku+json; version=3" \
  -H "Authorization: Bearer ${HEROKU_TOKEN}"
}

get_artifacts
# create