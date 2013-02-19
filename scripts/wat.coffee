# wat.
#

wat_pics = [
  "http://24.media.tumblr.com/tumblr_lfm5b0esis1qfzkwzo1_500.jpg",
  "http://i0.kym-cdn.com/photos/images/newsfeed/000/173/580/Wat.jpg",
  "http://i1.kym-cdn.com/photos/images/newsfeed/000/029/568/i_dont_even_cat.jpg"
]

module.exports = (robot) ->
  robot.hear "wat", (msg) ->
    console.log msg
    wat_pic = msg.random wat_pics
    msg.send "#{wat_pic}"


