# Display the winner when anyone asks
#

winner = [
 "pandas. always. join the rebellion."
]

module.exports = (robot) ->
  robot.hear /panda or badger/i, (msg) ->
    msg.send msg.random winner


