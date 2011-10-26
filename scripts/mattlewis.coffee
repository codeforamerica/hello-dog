# Things Matt Lewis Says
#

matt = [
 "i don't want to go to nerd parties",
 "or whatever your stupid startup is",
 "someone just needs to give me a lot of money for being cool"
]

module.exports = (robot) ->
  robot.hear /matt lewis/i, (msg) ->
    msg.send msg.random matt


