# Display a random "badger" image
#
# badgers - Returns a random badger image
#
#
badgers = [
, "http://www.issues.cc/uploads/26570518968.jpg"
, "http://www.thecaptainsmemos.com/wp-content/uploads/2010/08/10dumb/Snooki3.jpg"
,
"http://doctordanlyons.files.wordpress.com/2011/05/badger1.jpg"
,
"http://www.badassoftheweek.com/honeybadger3.jpg"
,
"http://www.janbrett.com/images/the_badger.jpg"
]
module.exports = (robot) ->
  robot.respond /badgers/i, (msg) ->
    msg.send msg.random badgers
