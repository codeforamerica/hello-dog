# Description:
#   A GitHub commit event emitter
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   rclosner

module.exports = (robot) ->
  robot.router.post "/hubot/gh-commits", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)

    res.end

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type

    try
      payload = JSON.parse req.body.payload
      if payload.commits.length > 0
        robot.emit "commit", {}
    catch error
      console.log "github-commits error: #{error}. Payload: #{req.body.payload}"
