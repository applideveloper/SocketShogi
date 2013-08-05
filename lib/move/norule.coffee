_ = require('underscore')

Masu = require('../masu')
Koma = require('../koma')
Sengo = require('../sengo')

# @param {board} Board
# @param {sasite} Object ## {masu: {before: Number, after: Number}, koma: Number, sengo: Number}

# callback
# info: {isValid: Boolean, reason: String (if not changed) }
# newBoard: Board (if isValid)
module.exports = (board, sasite, callback) ->
  if not callback? or (typeof callback) isnt 'function'
    throw new Error('callback is null or not a function')

  if not (sasite?.masu? and typeof sasite.masu.before == "number" and typeof sasite.masu.after == "number")
    callback new Error('sasite data is invalid')
    return

  if not Array.isArray(board)
    callback new Error('board is not an array')

  if not (Masu.isValid(sasite.masu.before) and Masu.isValid(sasite.masu.after))
    callback new Error('sasite.masu is invalid')
    return

  if sasite.masu.before == sasite.masu.after
    callback new Error('sasite is identical')
    return

  before = _.find board, (factor) ->
    sasite.masu.before is factor.masu and
      sasite.koma is factor.koma and
      sasite.sengo is factor.sengo
  
  if not before?
    callback new Error('sasite.before is not found in board')
    return

  newBoard = _.without board, before
  after = _.find newBoard, (factor) ->
    factor.masu is sasite.masu.after
    # 行き先に駒がある場合、beforeの駒台に移動する
  if after?
    newBoard = _.without newBoard, after
    newBoard.push {masu: Masu.KOMADAI, koma: Koma.toNama(after.koma), sengo: before.sengo}
  newBoard.push {masu: sasite.masu.after, koma: sasite.koma, sengo: sasite.sengo}

  callback null, newBoard
  return
