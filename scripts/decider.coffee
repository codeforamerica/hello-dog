# Description:
#   Having a problem with overly generous team members? Everyone willing to do
#   everything? That's when you need THE DECIDER.
#
# Commands:
# hubot decide "<task description>" - Randomly picks a user.

fellows = [
  "Alison Jones",
  "Andrew Hyder",
  "Ariel Kennan",
  "Lou Huang",
  "Ryan Closner",
  "Lindsay Ballant",
  "Marcin Wichary",
  "Laura Meixell",
  "Shaunak Kashyap",
  "Ezra Spier",
  "CJ Bryan",
  "Doneliza Joaquin",
  "Sheila Dugan",
  "Richa Agarwal",
  "Cris Cristina",
  "Jacob Solomon",
  "Marc K. Hébert",
  "Andy Hull",
  "Rebecca Ackerman",
  "Moncef Belyamani",
  "Sophia Parafina",
  "Anselm Bradford",
  "Tamara Manik-Perlman",
  "Dave Guarino",
  "Reed Duecy Gibbs",
  "Alan Williams",
  "Dan Avery",
  "Katie Lewis"
]

module.exports = (robot) ->
  robot.respond /decide who should (.*)/i, (msg) ->
    msg.reply("#{ msg.random fellows } will #{ msg.match[1] }")
