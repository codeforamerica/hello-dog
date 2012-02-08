# When is the BART?
#
# bart - Get the BART arrivals
JsDom = require 'jsdom'

module.exports = (robot) ->
  robot.respond /bart me\s*(\w*)/i, (msg) ->
    query msg, (body, err) ->
      if error = body.getElementsByTagName('error')[0]
        return msg.send "Error: "+error.getElementsByTagName("details")[0].textContent

      etd = body.getElementsByTagName('etd');

      stations = etd.toArray().map (current_etd) ->
        station = current_etd.getElementsByTagName("destination")[0].textContent
        minutes = current_etd.getElementsByTagName("estimate").toArray().map (estimate) ->
          estimate.getElementsByTagName("minutes")[0].textContent
        station+": "+minutes.join(", ")

      station_name = body.getElementsByTagName("name")[0].textContent

      msg.send "Upcoming trains for "+station_name+":\n\n"+stations.join("\n")



  getDom = (xml) ->
    body = JsDom.jsdom(xml)
    body

  query = (msg, cb) ->
    location = msg.match[1]
    req = msg.http('http://api.bart.gov/api/etd.aspx?cmd=etd&orig=civc&key=MW9S-E7SL-26DU-VV8V')
    req.query(orig: location) unless location.length == 0
    req.get() (err, res, body) ->
      try
        body = getDom body
      catch err
        err = 'Could not fetch BART data '
      cb(body, err)
