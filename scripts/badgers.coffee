# Display a random "badger" image
#
# badgers - Returns a random badger image
#
#
badgers = [
  "http://www.issues.cc/uploads/26570518968.jpg",
  "http://doctordanlyons.files.wordpress.com/2011/05/badger1.jpg",
  "http://www.badassoftheweek.com/honeybadger3.jpg",
  "http://www.janbrett.com/images/the_badger.jpg","http://homepage.ntlworld.com/keith.balmer/BNHS/focuson/badger%20network/images/phoning_badger.jpg",
  "Honey badger don't care.",
  "Honey badger just takes what it wants."
]
module.exports = (robot) ->
  robot.respond /badgers/i, (msg) ->
      msg.send msg.random badgers
