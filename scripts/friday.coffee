# Tomorrow is Saturday and Sunday comes afterwards.
#
# it's friday - Embeds Rebecca Black music video
#

module.exports = (robot) ->
  robot.respond /it's friday/i, (msg) ->
    msg.send "http://www.youtube.com/watch?v=kfVsfOSbJY0"
    msg.send "Looking forward to the weekend!"
