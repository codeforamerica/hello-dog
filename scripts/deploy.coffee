# Description:
#   Deploys app from GitHub to Heroku
#
# Dependencies:
#   None
#
# Configuration:
#   GITHUB_KEY
#   GITHUB_PUBLIC_KEY
#   GITHUB_URL
#   HEROKU_GIT_URL
#
# Commands:
#   hubot deploy - Deploys app from GitHub to Heroku
#
# Author:
#   rclosner
#   ngauthier

cp = require 'child_process'

module.exports = (robot) ->
  robot.respond /deploy/i, (msg) ->
    deploy(robot)

  robot.on "commit", (commit) ->
    deploy(robot)

deploy = (robot)
  deploy = cp.spawn './git-across.sh', [ 'run' ]
  emit = (data) ->
    robot.send(m) for m in data.toString().split("\n") when m.length > 0
  deploy.stdout.on 'data', emit
  deploy.stderr.on 'data', emit
