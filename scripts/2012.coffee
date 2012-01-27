# Things fellows say!
#

2012 = [
"It's like fate smacking you across the butt cheeks. -- sheeba",
"I've got .99999999 problems but floating point ain't 1! -- ruthie",
“I just put her name into the Google -- nick”,
"You know Stalin and the five year plan? Amateur. -- nick"
]

module.exports = (robot) ->
  robot.hear /(\s|^)(team|fellow|2012)/i, (msg) ->
    quote = msg.random matt
    msg.send "#{quote}"


