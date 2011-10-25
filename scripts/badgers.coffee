# Display a random "badger" image
#
# badgers - Returns a random badger image
#
#
badgers = [
  "http://ll-media.tmz.com/2010/12/15/celeb-snooki-240x285.jpg"
, "http://www.nypost.com/rw/nypost/2010/04/20/pagesix/photos_stories/cropped/snooki_splashnews--300x300.jpg"
, "http://crowdfusion.myspacecdn.com/media/2011/05/11/snooki-200x300.jpg"
, "http://www.issues.cc/uploads/26570518968.jpg"
, "http://www.thecaptainsmemos.com/wp-content/uploads/2010/08/10dumb/Snooki3.jpg"
]
module.exports = (robot) ->
  robot.respond /badgers/i, (msg) ->
    msg.send msg.random badgers
