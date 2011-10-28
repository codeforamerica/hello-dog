# Hello, yes this is dog
#
# hello - Hello, yes this is dog
#
#
module.exports = (robot) ->
  robot.respond /hello/i, (msg) ->
    msg.send "http://imgace.com/wp-content/uploads/2011/10/hello-yes-this-is-dog.png"
