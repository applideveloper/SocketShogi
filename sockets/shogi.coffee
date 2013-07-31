_ = require('underscore')

module.exports = (io) ->
  move = require('../lib/move')
  consts = require('../lib/consts')
  Koma = consts.Koma
  Masu = consts.Masu
  Sengo = consts.Sengo
  # karidesu
  board = consts.initBoard()

  nsShogi = io.of('/shogi')
  nsShogi.on 'connection', (socket) ->
    # TODO kari room
    roomName = 'はじまりのへや'
    socket.join roomName

    socket.on 'move', (sasite) ->
      # sasite: {masu: {before: Number, after: Number}, koma: Number, sengo: Number}
      move 'norule', board, sasite, (info, newBoard) ->
        if info.changed
          board = newBoard
        else
          console.log info.reason


    socket.on 'nari', (sasite) ->
      console.log 'nari'
      console.dir sasite
      # sasite: {masu: Number, koma: Number, sengo: Number}
      sasite && (
        before = _.find board, (factor) ->
          sasite.masu is factor.masu and
            sasite.koma is factor.koma and
            sasite.sengo is factor.sengo
        )
      if before
        before.koma = Koma.nari(sasite.koma)
        socket.emit 'board changed', board
