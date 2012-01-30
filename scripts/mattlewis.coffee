# Things Matt Lewis Says
#

matt = [
 "i don't want to go to nerd parties",
 "or whatever your stupid startup is",
 "someone just needs to give me a lot of money for being cool",
 "We're going to have to put patches on our jackets to distinguish us from the rabble",
 "Mjumbe, can you write me an absurdity algorithm please?",
 "A horse is like a motorcycle that takes shits",
 "Turns out that peace has a fucking terrible lobby.",
 "When you have this much chest hair things are 10 degrees warmer",
 "Code for America motherfucker! (while holding a tall boy)",
 "I never wanted to be little spoon so bad (re:Javier Barden)",
 "That's the good thing about having a beard, you can get beer on it.",
 "Why am I the voice of reason, here?!?",
 "I don't want to freak you guys out but I got like 68 twitter followers today. That's like a commuter flight",
 "You can't force those, that's like bad parenting",
 "I hate horses",
 "Does it ever bother you how amazing I am at the internet and you aren't?",
 "let me show you why i'm so awesome",
 "excuse me I have to put this banana in my pants",
 "there is a banana in my pants",
 "it's like putting an ant hill in a building",
 "it's not spam if it's coming out of my mouth",
 "Just fling the spent fuel rods into space - thats how you can deal with nuclear waste",
 "Fine, I'll learn vim - NOT! I blow people's minds just using google docs",
 "We [Americans] used to be taller before selective immigration of shorter people",
 "ML: I think I'm just going to drink until I can't feel feelings anymore. MK: You should be an attorney.",
 "I love that in San Francisco people will get upset if you go as Steve Jobs for Halloween, but no one would care if you rubbed shit all over yourself and went as Poop Jesus."
]

module.exports = (robot) ->
  robot.hear /(\s|^)(matt lewis)/i, (msg) ->
    quote = msg.random matt
    msg.send "#{quote} -Matt Lewis"


