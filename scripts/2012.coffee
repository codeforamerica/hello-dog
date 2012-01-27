# Things fellows say!
#

2012 = [
"It's like fate smacking you across the butt cheeks. -- sheeba",
"I've got .99999999 problems but floating point ain't 1! -- ruthie",
“I just put her name into the Google -- nick”,
"You know Stalin and the five year plan? Amateur. -- nick",
"So when are you gonna meet her mom? Can we at least dwell on the fun part of this?! -- prashant",
"This is not a momentum moment! -- nick",
"You need to leave an emotional taste of Nick in her mouth! -- prashant"
]

module.exports = (robot) ->
  robot.hear /(\s|^)(team|fellow|2012)/i, (msg) ->
    quote = msg.random matt
    msg.send "#{quote}"


