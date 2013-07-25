module.exports = (io) ->
  _ = require('underscore')
  consts = require('../lib/consts')
  Koma = consts.Koma
  Masu = consts.Masu
  Sengo = consts.Sengo

  # karidesu
  board = [{masu: 53, koma: Koma.FU, sengo:Sengo.GOTE}, {masu: 57, koma: Koma.FU, sengo: Sengo.SENTE}]

  nsShogi = io.of('/shogi')
  nsShogi.on 'connection', (socket) ->
    socket.on 'move', (sasite) ->
      # TODO この辺の処理はどっかのモデルのメソッド行き
      # モードによっても変わるので

      # sasite: {masu: {before: Number, after: Number}, koma: Number, sengo: Number}
      console.dir sasite
      sasite && sasite.masu && (
        before = _.find board, (factor) ->
          sasite.masu.before is factor.masu and
            sasite.koma is factor.koma and
            sasite.sengo is factor.sengo
        )
      if before
        newBoard = _.without board, before
        after = _.find newBoard, (factor) ->
          factor.masu is sasite.masu.after
        if after
          newBoard = _.without newBoard, after
          newBoard.push {masu: Masu.KOMADAI, koma: after.koma, sengo: after.sengo}
        newBoard.push {masu: sasite.masu.after, koma: sasite.koma, sengo: sasite.sengo}
        board = newBoard
        socket.emit 'board changed', board
      else
        # そのような手はさせない
        # 特に処理無しかな
    socket.on 'nari', (sasite) ->
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
