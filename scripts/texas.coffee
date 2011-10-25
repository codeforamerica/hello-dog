# Display an image of zach if anyone says "texas"
#

images = [
 "http://codeforamerica.org/wp-content/uploads/2011/10/Zach.jpg"
]

module.exports = (robot) ->
  robot.hear /texas/i, (msg) ->
    msg.send msg.random images


