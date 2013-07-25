module.exports = (io) ->
  Koma = require('../lib/koma')
  board = [{masu: 53, koma: Koma.FU, sengo:Koma.GOTE}, {masu: 57, koma: Koma:OU, sengo: Koma.SENTE}]

  nsShogi = io.of('/shogi')
  nsShogi.on 'connection', (socket) ->
    socket.emit 'board changed', board
