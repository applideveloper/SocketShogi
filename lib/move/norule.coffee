_ = require('underscore')

# board: Board
# sasite: {masu: {before: Number, after: Number}, koma: Number, sengo: Number}

# callback (info, newBoard)
# info: {changed: Boolean, reason: String (if not changed) }
# newBoard: Board (if changed)
module.exports = (board, sasite, callback) ->

  if not (sasite?.masu? and typeof sasite.masu.before == "number" and typeof sasite.masu.after == "number")
    callback {changed: false, reason: 'sasite is invalid'}
    return

  if sasite.masu.before == sasite.masu.after
    callback {changed: false, reason: 'sasite is identical'}
    return

  if not Array.isArray(board)
    callback {changed: false, reason: 'board is not an array'}
    return

  before = _.find board, (factor) ->
    sasite.masu.before is factor.masu and
      sasite.koma is factor.koma and
      sasite.sengo is factor.sengo
  
  if not before?
    callback {changed: false, reason: 'sasite.before is not found in board'}
    return

  newBoard = _.without board, before
  after = _.find newBoard, (factor) ->
    factor.masu is sasite.masu.after
    # 行き先に駒がある場合、beforeの駒台に移動する
    if after
      newBoard = _.without newBoard, after
      newBoard.push {masu: Masu.KOMADAI, koma: after.koma, sengo: before.sengo}
    newBoard.push {masu: sasite.masu.after, koma: sasite.koma, sengo: sasite.sengo}

  callback {changed: true}, newBoard
  return
