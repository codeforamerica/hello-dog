# Description:
#   Prints quotes from 2013 Code for America fellows.
#
# Dependencies:
#   google-spreadsheets
#
# Configuration:
#   HUBOT_BILLBOARD_ENDPOINT
#
# Commands:
#   2013 - print a random 2013 quote
#
# Author:
#   ahhrrr

module.exports = (robot) ->
  GoogleSpreadsheets = require("google-spreadsheets")

  opts =
    key: process.env.HUBOT_2013_QUOTE_KEY,
    worksheet: 1

  callback = (err, cells) ->
    try
      rows = cells['cells']

      # Populate array with all the quotes as strings
      quotes = for i, val of rows
        try
          name = val['1']['value']
          quote = val['2']['value']
          "\"#{quote}\" -#{name}"

      # Remove 2 rows with, column headings
      quotes = quotes[2..]

      # Bind hubot callback
      robot.hear /2013/i, (msg) ->
        quote = msg.random quotes
        msg.send quote
    catch error
      console.log "Error loading 2013 quotes: ", err

  GoogleSpreadsheets.cells(opts, callback)
