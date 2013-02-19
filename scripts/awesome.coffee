# awesome.wat
#
module.exports = (robot) ->
  robot.hear /awesome/i, (msg) ->
    msg.send "http://24.media.tumblr.com/tumblr_m4t3ip4A4B1r3xlxko1_400.png"
