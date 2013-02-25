# wat.
#

wat_pics = [
  "http://24.media.tumblr.com/tumblr_lfm5b0esis1qfzkwzo1_500.jpg",
  "http://i0.kym-cdn.com/photos/images/newsfeed/000/173/580/Wat.jpg",
  "http://i1.kym-cdn.com/photos/images/newsfeed/000/029/568/i_dont_even_cat.jpg",
  "http://i0.kym-cdn.com/photos/images/original/000/173/591/1VlCT.png",
  "http://i0.kym-cdn.com/photos/images/original/000/173/677/1310185912468.jpg"
]

module.exports = (robot) ->
  robot.hear /(^|\s)wat($|\s)/i, (msg) ->
    console.log msg
    wat_pic = msg.random wat_pics
    msg.send "#{wat_pic}"


