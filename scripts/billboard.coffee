# Description:
#   Displays an image on the office screens using billboard <https://github.com/dthompson/billboard>
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_BILLBOARD_ENDPOINT
#
# Commands:
#   billboard me <image url> - sends the image to the default screen.
#   billboard me <screen> screen <image url> - sends the image only to the specified screen
#   bb me <image url> - sends the image to the default screen.
#   bb me <screen> screen <image url> - sends the image only to the specified screen
#
# Author:
#   ahhrrr

defaultScreen = 'all'

module.exports = (robot) ->
  robot.respond /(billboard|bb) me( (\w+) screen)?(.+)/i, (msg) ->
    imageUrl = msg.match[4]
    screen = msg.match[3] || defaultScreen
    screenUrl = process.env.HUBOT_BILLBOARD_ENDPOINT + "/screens/"  + screen
    data = JSON.stringify(action:'image', url:imageUrl)
    msg.http(screenUrl)
      .headers("Content-Type": "application/json")
      .post(data) (err, res, body) ->
        # msg.send "it worked"
