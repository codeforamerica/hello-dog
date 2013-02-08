# Things CfA folk say!
#

q = [
   "\"I develop in the service of design, which is a pretentious way of saying I do front-end.\" -Marcin"
]

module.exports = (robot) ->
  robot.hear /(2013 fellows|CfA 2013)/i, (msg) ->
    console.log msg
    quote = msg.random q
    msg.send "#{quote}"


