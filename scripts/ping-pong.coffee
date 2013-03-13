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
#   hubot last <number> ping pong matches - Displays last n matches
#
# Author:
#   rclosner

elo = require("node-skill").elo
_   = require("underscore")

module.exports = (robot) ->

  robot.brain.data.ping_pong ||=
    players: {}
    matches: []

  robot.respond /(.*) (beat|lost to) (.*) (.*) to (.*) at ping pong/i, (msg) ->
    player     = msg.match[1]
    result     = msg.match[2]
    competitor = msg.match[3]
    score_a    = msg.match[4]
    score_b    = msg.match[5]

    if player == "i"
      player = msg.message.user.name

    match = Match.create( player, competitor, result, score_a, score_b )
    msg.send match.result()

  robot.respond /ping pong leaderboard\s?(by)?\s?(.*)?/i, (msg) ->
    attribute = msg.match[2] || "wins"
    msg.send PlayerRecords.by(attribute)

  robot.respond /last (.*) ping pong matches/i, (msg) ->
    num = msg.match[1]
    msg.send MatchRecords.last(num)

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

    update_rating: (competitor, result) ->
      rating = @get "rating"
      @set "rating", Math.floor rating + @_calculate_rating_change(competitor, result)

    save: () ->
      robot.brain.data.ping_pong.players[@name] = @attributes
      @

    get: (attribute) ->
      @attributes[attribute]

    set: (attribute, value) ->
      @attributes[attribute] = value

    setAttributes: (attrs) ->
      attrs = {} unless attrs

      defaults = _.clone(@defaults)
      attrs    = _.clone(attrs)

      @attributes = _(defaults).chain().extend(attrs).value()

    _calculate_rating_change: (competitor, result) ->
      rating = new elo.Rating( @get("rating") )
      competitor_rating  = new elo.Rating( competitor.get("rating")  )
      rating.calculateChange(competitor_rating, result)


  Player.find = (name) ->
    attrs = robot.brain.data.ping_pong.players[name]
    new Player(name, attrs) if attrs

  Player.create = (name, attrs) ->
    player = new Player(name, attrs)
    player.save()

  Player.find_or_create = (name, attrs) ->
    Player.find(name) || Player.create(name, attrs)

  Player.all = ->
    _(robot.brain.data.ping_pong.players)
      .chain()
      .pairs()
      .map( (obj) -> new Player obj[0], obj[1] )
      .value()

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
      @winner.update_rating(@loser, 1)
      @loser.update_rating(@winner, 0)

    get: (name) ->
      @attributes[name]

    set: (name, value) ->
      @attributes[name] = value

    setAttributes: (attrs) ->
      attrs = {} unless attrs
      @attributes = _(@defaults).chain().extend(attrs).clone().value()

    result: () ->
      winner_record = PlayerRecord.render(@winner)
      loser_record  = PlayerRecord.render(@loser)
      "#{ winner_record } \n#{ loser_record }"


  Match.limit = (num) ->
    _(robot.brain.data.ping_pong.matches)
      .chain()
      .values()
      .last(num)
      .map( (obj) -> new Match obj )
      .value()

  Match.create = (player, competitor, result, score_a, score_b) ->
    if result == "beat"
      winner_name = player
      loser_name  = competitor
    else if result == "lost to"
      winner_name = competitor
      loser_name  = player

    if parseInt(score_a) > parseInt(score_b)
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


  class PlayerRecords
    constructor: (players) ->
      @players = players

    sort: (attribute) ->
      @players = _(@players)
        .chain()
        .sortBy( (player) -> player.get(attribute) )
        .reverse()
        .value()
      @

    render: () ->
      _(@players).map((player) -> PlayerRecord.render(player)).join("\n")

  PlayerRecords.by = (attr) ->
    players = Player.all()
    (new @(players)).sort(attr).render()

  class PlayerRecord
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

  PlayerRecord.render = (player) ->
    (new @ player).render()

  class MatchRecords
    constructor: (matches) ->
      @matches = matches

    render: () ->
      _(@matches)
        .map( (match) -> MatchRecord.render(match) )
        .join("\n")

  MatchRecords.last = (num) ->
    matches = Match.limit(num)
    (new @(matches)).render()

  class MatchRecord
    constructor: (match) ->
      @match = match

    render: () ->
      "- #{ @_winner() } #{ @_loser() } #{ @_score() }"

    _winner: () ->
      "Winner: #{ @match.get('winner_name') }"

    _loser: () ->
      "Loser: #{ @match.get('loser_name') }"

    _score: () ->
      "Score: #{ @match.get('winner_score') } - #{ @match.get('loser_score') }"

  MatchRecord.render = (match) ->
    (new @(match)).render()
