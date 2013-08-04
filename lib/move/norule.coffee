_ = require('underscore')

Masu = require('../masu')
Koma = require('../koma')
Sengo = require('../sengo')

# @param {board} Board
# @param {sasite} Object ## {masu: {before: Number, after: Number}, koma: Number, sengo: Number}

# @return Object ## {isValid: Boolean, newBoard: Board)
# info: {isValid: Boolean, reason: String (if not changed) }
# newBoard: Board (if isValid)
module.exports = (board, sasite) ->

  if not (sasite?.masu? and typeof sasite.masu.before == "number" and typeof sasite.masu.after == "number")
    return {isValid: false, reason: 'sasite data is invalid'}

  if not Array.isArray(board)
    return {isValid: false, reason: 'board is not an array'}

  if not (Masu.isValid(sasite.masu.before) and Masu.isValid(sasite.masu.after))
    return {isValid: false, reason: 'sasite.masu is invalid'}

  if sasite.masu.before == sasite.masu.after
    return {isValid: false, reason: 'sasite is identical'}


  before = _.find board, (factor) ->
    sasite.masu.before is factor.masu and
      sasite.koma is factor.koma and
      sasite.sengo is factor.sengo
  
  if not before?
    return {isValid: false, reason: 'sasite.before is not found in board'}

  newBoard = _.without board, before
  after = _.find newBoard, (factor) ->
    factor.masu is sasite.masu.after
    # 行き先に駒がある場合、beforeの駒台に移動する
  if after
    newBoard = _.without newBoard, after
    newBoard.push {masu: Masu.KOMADAI, koma: after.koma, sengo: before.sengo}
  newBoard.push {masu: sasite.masu.after, koma: sasite.koma, sengo: sasite.sengo}

  return {isValid: true, newBoard: newBoard}
