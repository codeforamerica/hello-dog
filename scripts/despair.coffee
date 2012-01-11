#
# Demotivational quotes 
#

despair = {
  blame: "The secret to success is knowing who to blame for your failures.",
  blogging: "Never before have so many people with so little to say said so much to so few.",
  diversity: "Because every person deserves an equal chance to prove their incompetence.",
  doubt: "n the battle between you and the world, bet on the world.",
  hope: "May not be warranted at this point.",
  compromise: "Let's agree to respect each others views, no matter how wrong yours may be.",
  consistency: "It's only a virtue if you're not a screwup.",
  failure: "When your best just isn't good enough.",
  fear: "Until you have the courage to lose sight of the shore, you will not know the terror of being forever lost at sea.",
  innovation: "If it can make your job easier, it can probably make it irrelevant.",
  persistence: "It's over, man. Let her go.",
  power: "Power corrupts. Absolute power corrupts absolutely. But it rocks absolutely, too.",
  quality: "The race for quality has no finish line- so technically, it's more like a death march.",
  planning: "Much work remains to be done before we can announce our total failure to make any progress.",
  problems: "No matter how great and destructive your problems may seem now, remember, you've probably only seen the tip of them.",
  regret: "It hurts to admit when you make mistakes - but when they're big enough, the pain only lasts a second.",
  retirement: "Because you've given so much of yourself to the company that you don't have anything left we can use.",
  success: "Some people dream of success, while other people live to crush those dreams.",
  trouble: "Luck can't last a lifetime unless you die young.",
  winners: "Because nothing says \"you're a loser\" more than owning a motivational poster about being a winner.",
  vision: "How can the future be so hard to predict when all of my worst fears keep coming true?",
  wisdom: "Sometimes the only difference between a budding genius and a blooming idiot is where they choose to take a stand."
}

search = for word, phrase of despair
  "#{word}"

searchString = search.join "|"
searchString = RegExp "\\b(#{searchString})\\b", "i"

module.exports = (robot) ->
  robot.hear searchString, (msg) ->
    url = "http://demotivators.despair.com/#{msg.match[1]}demotivator.jpg"
    text = "#{msg.match[1].toUpperCase()}: #{despair[msg.match[1].toLowerCase()]} #{url}"
    msg.send text
