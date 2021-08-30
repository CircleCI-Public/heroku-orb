# heroku Orb [![CircleCI Build Status](https://circleci.com/gh/CircleCI-Public/heroku-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/CircleCI-Public/heroku-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/circleci/heroku.svg)](https://circleci.com/orbs/registry/orb/circleci/heroku) [![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/CircleCI-Public/heroku-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

Easily install and use the Heroku CLI with CircleCI to build, test, and deploy your applications to Heroku.

## Usage

Example use-cases are provided on the orb [registry page](https://circleci.com/orbs/registry/orb/circleci/heroku#usage-examples). Source for these examples can be found within the `src/examples` directory.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/circleci/heroku) - The official registry page of this orb for all versions, executors, commands, and jobs described.  
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.  

### How To Contribute

We welcome [issues](https://github.com/CircleCI-Public/heroku-orb/issues) to and [pull requests](https://github.com/CircleCI-Public/heroku-orb/pulls) against this repository!

To publish a new production version:
* Create a PR to the `Alpha` branch with your changes. This will act as a "staging" branch.
* When ready to publish a new production version, create a PR from `Alpha` to `master`. The Git Subject should include `[semver:patch|minor|release|skip]` to indicate the type of release.
* On merge, the release will be published to the orb registry automatically.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).
