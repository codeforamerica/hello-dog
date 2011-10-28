# When is the BART?
#
# bart - Get the BART arrivals
JsDom = require 'jsdom'

module.exports = (robot) ->
  robot.respond /bart me (.*)/i, (msg) ->
    query msg, (body, err) ->
      return msg.send err if err

      etd = body.getElementsByTagName('etd')[0];
      return msg.send 'No Etd -> no platform.' if not etd or not etd.getAttribute

      strings = []
      strings.push "#{etd.getAttribute('destination')}"

      msg.send strings.join "\n"

  getDom = (xml) ->
    body = JsDom.jsdom(xml)
    throw Error('No xml') if body.getElementsByTagName('etd')[0].childNodes.length == 0
    body

  query = (msg, cb) ->
    location = msg.match[1]
    msg.http('http://api.bart.gov/api/etd.aspx?cmd=etd&orig=mont&key=MW9S-E7SL-26DU-VV8V')
      .query(orig: location)
      .get() (err, res, body) ->
        try
          body = getDom body
        catch err
          err = 'Could not fetch BART data '
        cb(body, err)
