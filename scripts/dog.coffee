# Hello, yes this is dog
#
# pandas - Returns a random panda image
#
#
module.exports = (robot) ->
  robot.respond /dog/i, (msg) ->
    msg.send "http://imgace.com/wp-content/uploads/2011/10/hello-yes-this-is-dog.png"
