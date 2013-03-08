# Description:
#   Reminds/Corrects the fellows on basic CfA knowledge.
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
  robot.hear /whose fellowship/, (msg) ->
    msg.send "This is OUR fellowship."

module.exports = (robot) ->
  robot.hear /city\s?(-)?folk/, (msg) ->
    msg.send "I think you mean city officials..."
