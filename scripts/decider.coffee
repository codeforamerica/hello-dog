# Description:
#   Having a problem with overly generous team members? Everyone willing to do
#   everything? That's when you need THE DECIDER.
#
# Commands:
# hubot decide "<task description>" - Randomly picks a user.

ENDPOINT = "http://cfa-api.herokuapp.com/v0/fellows"

module.exports = (robot) ->
  robot.respond /decide who (within)?\s?(team)?\s?(.*)?\s?(should|will) (.*)/i, (msg) ->
    query     = {}
    hasScope  = msg.match[1] == "within"
    parameter = msg.match[2]
    value     = msg.match[3]
    verb      = msg.match[4]
    action    = msg.match[5]

    if hasScope
      query[parameter] = value

    handler = (fellows) ->
      msg.send "#{ msg.random fellows } #{ verb } #{ action }"

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
