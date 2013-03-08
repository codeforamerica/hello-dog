# Description:
#   Having a problem with overly generous team members? Everyone willing to do
#   everything? That's when you need THE DECIDER.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot decide who will <task> - Randomly picks a fellow from all fellows
#   hubot decide who should <task> - Randomly picks a fellow from all fellows
#   hubot decide who within <parameter> <value> should <task> - Randomly picks a fellow from a scope
#   hubot decide who within <parameter> <value> will <task> - Randomly picks a fellow from a scope
#   hubot decide who from <parameter> <value> should <task> - Randomly picks a fellow from a scope
#   hubot decide who from <parameter> <value> will <task> - Randomly picks a fellow from a scope
#
# Author:
#   rclosner

ENDPOINT = "http://cfa-api.herokuapp.com/v0/fellows"

module.exports = (robot) ->
  robot.respond /decide who (within|from)?\s?(team)?\s?(.*)?\s?(should|will) (.*)/i, (msg) ->
    query     = {}
    hasScope  = (msg.match[1] == "within" or msg.match[1] == "from")
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
