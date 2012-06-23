# Things CfA folk say!
#

q = [
  "It's like fate smacking you across the butt cheeks. -- sheba",
  "I've got .99999999 problems but floating point ain't 1! -- ruthie",
  "CfA Peanut Gallery: So did you look her [love interest] up yet? Nick: I just put her name into the Google",
  "You know Stalin and the five year plan? Amateur. -- nick, on dating",
  "So when are you gonna meet her mom? Can we at least dwell on the fun part of this?! -- prashant, on nick dating",
  "This is not a momentum moment! -- nick, on dating",
  "You need to leave an emotional taste of Nick in her mouth! -- prashant, on dating",
  "I can't say that aloud. That would be an HR violation. -- abhi",
  "I've known cold and heartless people and... like, they're in my family. -- nick",
  "I think there is a lot of money to be made in Macon. -- zach",
  "I would rather live here - in Macon - than Canada. -- nick",
  "I've got Klavika. -- zach",
  "It's not a view if you're falling. -- prashant",
  "It's not stealing if you ask. -- prashant",
  "I'm telling you this, 1970 was the apex of American culture! -- liz",
  "Death on triscuit. -- abhi",
  "Abhi, you wear more cardigans than Mr. Rogers! -- liz",
  "liz: I just thought of the blog post I'm going to write in my alternate persona. abhi: That's like 'shit English PhD's say'!",
  "We should take you to the Mutter Museum [of medical curiosities] and lock you up! -- liz, to abhi",
  "Fiiiiiirebuuuugggg...I looove yoouuuuu -- tamara",
  "This is a cult, not a family! -- maxogden",
  "My ex-boyfriend used to say duh-jango, and he knew more than you! -- sheba, to alex y",
  "You shouldn't be anyone other than who you are! -- sheba, to alex p",
  "Isn't excessive altruism a sign of Parkinson's? -- nick",
  "I don't think enough people travel via extradition. -- nick",
  "This div is wrapping. Wrapping like a gangster. -- michelle, on bootstrap grid",
  "Your mom is a box model. -- ruthie, on css",
  "It's, like, totally going viral on google docs! -- Hannah"
]

module.exports = (robot) ->
  robot.hear /(2012 fellows|CfA 2012)/i, (msg) ->
    console.log msg
    quote = msg.random q
    msg.send "#{quote}"


