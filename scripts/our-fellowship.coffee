module.exports = (robot) ->
  robot.hear /whose fellowship/ (msg) ->
    msg.send "this is OUR fellowship"
