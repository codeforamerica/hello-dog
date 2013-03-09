# Description:
#   Keeps track of ping pong wins and losses
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
  robot.brain.data.ping_pong_games ||=
    won:  {}
    lost: {}

  pingPong =
    winners: ->
      data = robot.brain.data.ping_pong_games
      _.keys(data.won)
    losers: ->
      data = robot.brain.data.ping_pong_games
      _.keys(data.lost)
    players: ->
      _.chain([@winners(), @losers()]).flatten().uniq().value()
    incrementLost: (player) ->
      data = robot.brain.data.ping_pong_games
      data.lost[player] = 0 unless data.lost[player]
      data.lost[player] += 1
    incrementWon: (player) ->
      data = robot.brain.data.ping_pong_games
      data.won[player] = 0 unless data.won[player]
      data.won[player] += 1
    getWon: (player) ->
      data = robot.brain.data.ping_pong_games
      data.won[player] || 0
    getLost: (player) ->
      data = robot.brain.data.ping_pong_games
      data.lost[player] || 0
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
