# Hello, yes this is dog
#
# dog - Hello, yes this is doge
#
#
module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "http://imgace.com/wp-content/uploads/2011/10/hello-yes-this-is-dog.png"
