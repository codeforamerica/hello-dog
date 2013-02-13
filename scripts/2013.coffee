module.exports = (robot) ->
  GoogleSpreadsheets = require("google-spreadsheets")

  opts =
    key: process.env.HUBOT_2013_QUOTE_KEY,
    worksheet: 1

  callback = (err, cells) ->
    rows = cells['cells']

    # Populate array with all the quotes as strings
    quotes = for i, val of rows
      name = val['1']['value']
      quote = val['2']['value']
      '"' + quote + '" -' + name

    # Remove column headings
    quotes = quotes.slice 1, quotes.length

    # Bind hubot callback
    robot.hear(/2013/i, (msg) ->
      quote = msg.random(quotes);
      msg.send(quote);
    )

  GoogleSpreadsheets.cells(opts, callback)
