# Things CfA folk say!
#

q = [
   '"I develop in the service of design, which is a pretentious way of saying I do front-end." -Marcin',
   '"A yolodex is a list of people that you\'d call up if you wanted to hang out and be really irresponsible." -CJ',
   '"WE THE SHEEPLE" -Dave',
   '"Vine is generally a great medium for shitshows." -Alan',
   '"I don\'t really have worse clothes." -Marcin, departing for the Louisville PD ride-along',
   '"chinatown in las vegas is just a series of suburban strip malls with chinese restaurants in them\nit\'s actually labeled \"chinatown\" on the map\nwhich is funny because in the bay area we call that \"milpitas\"" -Lou'
]

module.exports = (robot) ->
  robot.hear /2013/i, (msg) ->
    console.log msg
    quote = msg.random q
    msg.send "#{quote}"


