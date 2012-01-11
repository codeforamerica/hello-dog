#
# Demotivational quotes 
#

despair = {
  diversity: "Because every person deserves an equal chance to prove their incompetence.",
  hope: "May not be warranted at this point.",
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
