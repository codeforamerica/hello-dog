# Description:
#   Keep track of ping pong wins and losses
#
# Dependencies:
#   "underscore" : ""
#
# Configuration:
#   None
#
# Commands:
#   hubot I beat <user> at ping pong - Incremenets wins and losses for users
#   hubot I lost to <user> at ping pong - Increments wins and losses for users
#
# Author:
#   rclosner

_ = require("underscore")

module.exports = (robot) ->
  robot.brain.data.pingPongGames =
    won:  {}
    lost: {}

  pingPong =
    winners: ->
      _.keys(robot.brain.data.pingPongGames.won)
    losers: ->
      _.keys(robot.brain.data.pingPongGames.lost)
    players: ->
      _.chain([@winners(), @losers()]).flatten().uniq().value()
    incrementLost: (player) ->
      robot.brain.data.pingPongGames.lost[player] = 0 if (pingPong.getLost(player) <= 0)
      robot.brain.data.pingPongGames.lost[player] += 1
    incrementWon: (player) ->
      robot.brain.data.pingPongGames.won[player] = 0 if (pingPong.getWon(player) <= 0)
      robot.brain.data.pingPongGames.won[player] += 1
    getWon: (player) ->
      robot.brain.data.pingPongGames.won[player] || 0
    getLost: (player) ->
      robot.brain.data.pingPongGames.lost[player] || 0
    getRecord: (player) ->
      "W: #{ pingPong.getWon(player) } L: #{ pingPong.getLost(player) }"
    getLeaderboard: () ->
      players = pingPong.players()
      _.chain(players).sortBy(
        (player) -> pingPong.getWon(player)
      ).map(
        (player) -> "#{ player } #{ pingPong.getRecord(player) }"
      ).value().reverse().join("\n")

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

    pingPong.incrementWon(winner)
    pingPong.incrementLost(loser)

    displayRecord(msg, winner, loser)

  robot.respond /leaderboard/i, (msg) ->
    msg.send pingPong.getLeaderboard()
