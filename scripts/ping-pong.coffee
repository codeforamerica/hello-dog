# Description:
#   Keep track of ping pong wins and losses
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Author:
#   rclosner

module.exports = (robot) ->
  robot.brain.data.pingPongGames =
    won:  {}
    lost: {}

  pingPong =
    incrementLost: (user) ->
      robot.brain.data.pingPongGames.lost[user] = 0 unless robot.brain.data.pingPongGames.lost[user]
      robot.brain.data.pingPongGames.lost[user] += 1
    incrementWon: (user) ->
      robot.brain.data.pingPongGames.won[user] = 0 unless robot.brain.data.pingPongGames.won[user]
      robot.brain.data.pingPongGames.won[user] += 1
    getWon: (user) ->
      robot.brain.data.pingPongGames.won[user] || 0
    getLost: (user) ->
      robot.brain.data.pingPongGames.lost[user] || 0
    getRecord: (user) ->
      "W: #{ @getWon(user) } L: #{ @getLost(user) }"

  displayRecord = (msg, winner, loser) ->
    msg.send "#{ winner } - #{ pingPong.getRecord(winner) } #{ loser } - #{ pingPong.getRecord(loser) }"

  robot.respond /I beat (.*) at ping pong/i, (msg) ->
    winner = msg.message.user.name
    loser  = msg.match[1]

    pingPong.incrementWon(winner)
    pingPong.incrementLost(loser)

    displayRecord(msg, winner, loser)


  robot.respond /I lost to (.*) at ping pong/i, (msg) ->
    loser  = msg.message.user.name
    winner = msg.match[1]

    msg.send loser
    pingPong.incrementWon(winner)
    pingPong.incrementLost(loser)

    displayRecord(msg, winner, loser)
