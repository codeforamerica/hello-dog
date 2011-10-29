# When is the BART?
#
# bart - Get the BART arrivals
JsDom = require 'jsdom'

module.exports = (robot) ->
  robot.respond /bart me (.*)/i, (msg) ->
    query msg, (body, err) ->
      return msg.send err if err

      etd = body.getElementsByTagName('etd');

      stations = etd.toArray().map (current_etd) ->
        console.log("mapping "+current_etd.textContent);
        station = current_etd.getElementsByTagName("destination")[0].textContent
        minutes = current_etd.getElementsByTagName("estimate").toArray().map (estimate) ->
          estimate.getElementsByTagName("minutes")[0].textContent
        station+": "+minutes.join(", ")
      
      msg.send stations.join("\n")



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
