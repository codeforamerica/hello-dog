# Display the winner when anyone asks
#

winner = [
 "pandas. always. join the rebellion."
 "Obviously badgers win."
 "Rangers. Cardinals suck."
]

module.exports = (robot) ->
  robot.hear /panda.*badger.*|badger.*panda.*/i, (msg) ->
    msg.send msg.random winner


