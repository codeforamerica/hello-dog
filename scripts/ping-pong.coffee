# Description:
#   Keeps track of ping pong wins/losses
#
# Dependencies:
#   "underscore" : ""
#   "node-skill" ; ""
#
# Configuration:
#   None
#
# Commands:
#   hubot I lost to <competitor> <score_1> to <score_2> at ping pong- Adds 1 loss to user and 1 win to competitor; also updates player rankings for both current user and competitor.
#   hubot I beat <user> <score_1> to <score_2> at ping pong- Adds 1 win to user and 1 loss to competitor; also updagtes player rankings for both current user and competitor.
#   hubot ping pong leaderboard - Displays player leaderboard (default sort is by "wins").
#   hubot ping pong leaderboard by <attribute> - Displays player leaderboard sorted by attributes (acceptable values: "wins", "losses", "rating").
#
# Author:
#   rclosner

elo = require("node-skill").elo
_   = require("underscore")

module.exports = (robot) ->

  robot.brain.data.ping_pong ||=
    players: {}
    matches: []

  robot.respond /i (beat|lost to) (.*) (.*) to (.*) at ping pong/i, (msg) ->
    player     = msg.message.user.name
    result     = msg.match[1]
    competitor = msg.match[2]
    score_a    = msg.match[3]
    score_b    = msg.match[4]

    match = Match.create( player, competitor, result, score_a, score_b )
    msg.send match.result()

  robot.respond /ping pong leaderboard\s?(by)?\s?(.*)?/i, (msg) ->
    attribute = msg.match[2] || "wins"
    msg.send Leaderboard.by(attribute)

  ##################################################
  ## Models
  ##################################################


  class Player
    constructor: (name, attrs) ->
      @name = name
      @setAttributes(attrs)

    attributes: {}

    defaults:
      rating: 1400
      wins: 0
      losses: 0

    increment_wins: ->
      wins = @get("wins")
      wins += 1
      @set("wins", wins)

    increment_losses: ->
      losses = @get("losses")
      losses += 1
      @set("losses", losses)

    save: () ->
      robot.brain.data.ping_pong.players[@name] = @attributes
      @

    get: (attribute) ->
      @attributes[attribute]

    set: (attribute, value) ->
      @attributes[attribute] = value

    setAttributes: (attrs) ->
      attrs = {} unless attrs
      @attributes = _(@defaults).chain().extend(attrs).clone().value()

  Player.find = (name) ->
    attrs = robot.brain.data.ping_pong.players[name]
    new Player(name, attrs) if attrs

  Player.create = (name, attrs) ->
    player = new Player(name, attrs)
    player.save()

  Player.find_or_create = (name, attrs) ->
    Player.find(name) || Player.create(name, attrs)

  Player.all = ->
    _(robot.brain.data.ping_pong.players).chain().pairs().map(
      (obj) -> new Player obj[0], obj[1]
    ).value()

  class Match
    constructor: (attrs) ->
      @setAttributes(attrs)
      @winner = Player.find_or_create @get("winner_name")
      @loser  = Player.find_or_create @get("loser_name")

    attributes: {}

    defaults:
      winner_name: undefined
      winner_score: undefined
      loser_name: undefined
      loser_score: undefined

    save: () ->
      @update_player_records()
      @update_player_ratings()

      @winner.save()
      @loser.save()

      robot.brain.data.ping_pong.matches.push @attributes
      @

    update_player_records: () ->
      @winner.increment_wins()
      @loser.increment_losses()

    update_player_ratings: () ->
      winner_rating = new elo.Rating( @winner.get("rating") )
      loser_rating  = new elo.Rating( @loser.get("rating")  )

      winner_change = winner_rating.calculateChange(loser_rating, 1)
      loser_change  = loser_rating.calculateChange(winner_rating, 0)

      @winner.set "rating", Math.floor winner_rating.value - winner_change
      @loser.set  "rating", Math.floor loser_rating.value  - loser_change

    get: (name) ->
      @attributes[name]

    set: (name, value) ->
      @attributes[name] = value

    setAttributes: (attrs) ->
      attrs = {} unless attrs
      @attributes = _(@defaults).chain().extend(attrs).clone().value()

    result: () ->
      winner_record = LeaderboardRow.render(@winner)
      loser_record  = LeaderboardRow.render(@loser)
      "#{ winner_record } \n #{ loser_record }"


  Match.create = (player, competitor, result, score_a, score_b) ->
    if result == "beat"
      winner_name = player
      loser_name  = competitor
    else if result == "lost to"
      winner_name = competitor
      loser_name  = player

    if score_a > score_b
      winner_score = score_a
      loser_score  = score_b
    else
      winner_score = score_b
      loser_score  = score_a

    attrs =
      winner_name:  winner_name
      loser_name:   loser_name
      winner_score: winner_score
      loser_score:  loser_score

    (new @(attrs)).save()


  ##################################################
  ## View Helpers
  ##################################################


  class Leaderboard
    constructor: () ->
      @players = Player.all()

    sort: (attribute) ->
      _(@players)
        .chain()
        .sortBy( (player) -> player.get(attribute) )
        .map( (player) -> LeaderboardRow.render(player) )
        .reverse()
        .value()
        .join("\n")

  Leaderboard.by = (attr) ->
    (new @).sort(attr)

  class LeaderboardRow
    constructor: (player) ->
      @player = player

    render: () ->
      "#{ @_name() } \n  * #{ @_wins() } #{ @_losses() } #{ @_rating() }"

    _name: () ->
      "#{ @player.name }"
    _wins: () ->
      "Wins: #{ @player.get('wins') }"

    _losses: () ->
      "Losses: #{ @player.get('losses') }"

    _rating: () ->
      "Rating: #{ @player.get('rating') }"

  LeaderboardRow.render = (player) ->
    (new @ player).render()
