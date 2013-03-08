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
  robot.on "commit", (commit) ->
    send = (m) -> robot.send(commit.user, m)
    deployApp(send)

  robot.respond /deploy/i, (msg) ->
    send = (m) -> msg.send(m)
    deployApp(send)

deployApp = (send) ->
  deploy = cp.spawn './git-across.sh', [ 'run' ]
  emit = (data) ->
    send(m) for m in data.toString().split("\n") when m.length > 0
  deploy.stdout.on 'data', emit
  deploy.stderr.on 'data', emit
