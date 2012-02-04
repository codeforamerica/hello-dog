# Things fellows say!
#

q = [
  "It's like fate smacking you across the butt cheeks. -- sheeba",
  "I've got .99999999 problems but floating point ain't 1! -- ruthie",
  "CfA Peanut Gallery: So did you look her [love interest] up yet? Nick: I just put her name into the Google",
  "You know Stalin and the five year plan? Amateur. -- nick, on dating",
  "So when are you gonna meet her mom? Can we at least dwell on the fun part of this?! -- prashant, on nick dating",
  "This is not a momentum moment! -- nick, on dating",
  "You need to leave an emotional taste of Nick in her mouth! -- prashant, on dating",
  "I can't say that aloud. That would be an HR violation. -- abhi",
  "I've known cold and heartless people and... like, they're in my family. -- nick",
  "I think there is a lot of money to be made in Macon. -- zach",
  "I would rather live here - in Macon - than Canada. -- nick"
  "I've got Klavika." -- zach
]

module.exports = (robot) ->
  robot.hear /(2012 fellows)/i, (msg) ->
    console.log msg
    quote = msg.random q
    msg.send "#{quote}"


