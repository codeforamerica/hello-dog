# Description:
#   DNA BOMB!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot DNA bomb- A DNA explosion!
#   hubot DNA bomb <times>- A DNA explosion multiplied by <times>!
#
# Author:
#   rclosner

module.exports = (robot) ->
  robot.respond /DNA bomb\s?(.*)?/i, (msg) ->
    num = msg.match[1] || 10
    msg.send DNAGenerator(num)

  DNAGenerator = (num) ->
    times    = num * 1000
    sequence = ""

    rnd = () ->
      Math.floor( Math.random() * 10 )

    add_letter = ->
      letter = ""
      if (rnd() < 5)
        letter = "G"
        letter = "C" if rnd() < 5
      else
        letter = "A"
        letter = "T" if rnd() < 5
      sequence += letter

    for i in [0..(times)] by 1
      add_letter()

    sequence
