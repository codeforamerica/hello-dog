# Description:
#   Having a problem with overly generous team members? Everyone willing to do
#   everything? That's when you need THE DECIDER.
#
# Commands:
# hubot decide "<task description>" - Randomly picks a user.

ENDPOINT = "http://cfa-api.herokuapp.com/v0/fellows"

module.exports = (robot) ->
  robot.respond /decide who( within)?( .*)? (should|will) (.*)/i, (msg) ->
    query = {}
    query.team = msg.match[2] if msg.match[1] == " within"
    handler = (fellows) ->
      msg.send "#{ msg.random fellows } #{ msg.match[3] } #{ msg.match[4] }"
    getFellows(msg, query, handler)

getFellows = (msg, query, handler) ->
  msg.http(ENDPOINT)
    .query(query)
    .get() (err, res, body) ->
      json = JSON.parse(body)
      fellowName = (fellow) ->
        fellow["fellow"]["name"]
      fellows = (fellowName fellow for fellow in json)
      handler(fellows)
