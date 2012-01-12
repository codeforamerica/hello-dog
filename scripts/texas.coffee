# Display an image of zach if anyone says "texas"
#

images = [
 "http://codeforamerica.org/wp-content/uploads/2011/10/Zach.jpg",
 "http://codeforamerica.org/wp-content/uploads/2011/10/Emily.jpg",
 "http://codeforamerica.org/wp-content/uploads/2011/10/alex.png",
 "http://codeforamerica.org/wp-content/uploads/2011/10/Diana.jpg",
 "http://codeforamerica.org/wp-content/uploads/2011/10/Prashant.jpg"
]

module.exports = (robot) ->
  robot.hear /texas/i, (msg) ->
    msg.send msg.random images


