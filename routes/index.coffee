exports.index = (req, res) ->
  res.render 'index'

exports.rooms = require('./rooms')
