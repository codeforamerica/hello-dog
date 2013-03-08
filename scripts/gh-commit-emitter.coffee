# Description:
#   An HTTP Listener / Event Emitter for GitHub Commits
#
# Dependencies:
#   "querystring" : ""
#   "url" : ""
#
# Configuration:
#   Just put this url <HUBOT_URL>:<PORT>/hubot/gh-commits?room=<room> into you'r github hooks
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/gh-commits?room=<room>[&type=<type]
#
# Authors:
#   rclosner

url         = require('url')
querystring = require('querystring')

module.exports = (robot) ->

  robot.router.post "/hubot/gh-commits", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)

    res.end

    user      = {}
    user.room = query.room if query.room
    user.type = query.type if query.type

    try
      payload = JSON.parse req.body.payload

      if payload.repository.name == "hello-dog" and payload.commits.length > 0
        robot.emit "commit", {
          user: user
        }

        robot.send user, "Got #{ payload.commits.length } new commits from #{ payload.commits[0].author.name } on #{ payload.repository.name }"

    catch error
      console.log "github-commits error: #{error}. Payload: #{req.body.payload}"
