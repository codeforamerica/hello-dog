# Display a random "panda" image
#
# pandas - Returns a random panda image
#
#
pandas = [
  "http://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG"
, "http://nationalzoo.si.edu/Animals/GiantPandas/PandaFacts/images/cover_MeiXiang.jpg"
, "http://3.bp.blogspot.com/_y3nuvfvSQF0/TSJn-Hi-VCI/AAAAAAAAA9U/Htyh8gzNRvU/s1600/pandas.jpg"
, "http://i671.photobucket.com/albums/vv78/Sinsei55/HatersGonnaHatePanda.jpg"
, "http://24.media.tumblr.com/tumblr_lzpxkntyDS1r0wqrdo1_500.jpg"
]
module.exports = (robot) ->
  robot.respond /pandas/i, (msg) ->
    msg.send msg.random pandas
