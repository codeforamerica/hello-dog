# Tomorrow is Saturday and Sunday comes afterwards.
#
# it's friday - Embeds Rebecca Black music video
#

module.exports = (robot) ->
  robot.respond /friday me/i, (msg) ->
    msg.send "http://www.youtube.com/watch?v=kfVsfOSbJY0"
    msg.send "Partying. Partying. YEAH!"
  robot.respond /it's friday/i, (msg) ->
    msg.send "http://www.youtube.com/watch?v=kfVsfOSbJY0"
    msg.send "Looking forward to the weekend!"
  robot.respond /(what day is|what is today)/i, (msg) ->
    date = new Date()
    if date.getDay() == 5
      msg.send "http://www.youtube.com/watch?v=kfVsfOSbJY0"
      msg.send "It's Friday!"
