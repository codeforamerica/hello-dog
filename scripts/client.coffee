# Display a random "client bear" image
#
# client - Returns a random client image
#
#
client = [
  "http://25.media.tumblr.com/tumblr_liw80mBMhe1qbf9m8o1_500.png",
  "http://30.media.tumblr.com/tumblr_liioafvK8x1qbf9m8o1_500.png",
  "http://29.media.tumblr.com/tumblr_lif68sOFDB1qbf9m8o1_500.png",
  "http://25.media.tumblr.com/tumblr_li64p4n3rv1qbf9m8o1_500.png",
  "http://28.media.tumblr.com/tumblr_lhcm3sm6gA1qbf9m8o1_500.png",
  "http://29.media.tumblr.com/tumblr_lhv2zlFJtw1qbf9m8o1_500.png",
  "http://30.media.tumblr.com/tumblr_lhtaj7II9n1qbf9m8o1_500.png",
  "http://26.media.tumblr.com/tumblr_lhi4pgxdZK1qbf9m8o1_500.png",
  "http://26.media.tumblr.com/tumblr_lheb1zzIpt1qbf9m8o1_500.png",
  "http://24.media.tumblr.com/tumblr_lhcmdxbrMf1qbf9m8o1_500.png",
  "http://25.media.tumblr.com/tumblr_lhcldur2Aj1qbf9m8o1_500.png",
  "http://24.media.tumblr.com/tumblr_lh6u4jT8mt1qbf9m8o1_500.png",
  "http://29.media.tumblr.com/tumblr_lh30mgiwr51qbf9m8o1_500.png",
  "http://28.media.tumblr.com/tumblr_lh1elkrfxp1qbf9m8o1_500.png",
  "http://27.media.tumblr.com/tumblr_lh10kb56N71qbf9m8o1_500.png",
  "http://28.media.tumblr.com/tumblr_lgu0wfj4kC1qbf9m8o1_500.png",
  "http://30.media.tumblr.com/tumblr_lgtuq9Ttze1qbf9m8o1_500.png",
  "http://28.media.tumblr.com/tumblr_lgs4x2jGii1qbf9m8o1_500.png"
  ]
module.exports = (robot) ->
  robot.respond /clientbear/i, (msg) ->
    msg.send msg.random client
