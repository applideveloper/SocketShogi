_ = require('underscore')

consts = require('/lib/consts')
Masu = consts.Masu
Koma = require('/lib/koma')

# board: Board
# sasite: {masu: {before: Number, after: Number}, koma: Number, sengo: Number, nari: Boolean}

# callback (info, newBoard)
# info: {changed: Boolean, reason: String (if not changed) }
# newBoard: Board (if changed. otherwise, it will be null)
module.exports = (board, sasite, callback) ->

  if not (sasite?.masu? and typeof sasite.masu.before == "number" and typeof sasite.masu.after == "number")
    callback {changed: false, reason: 'sasite is invalid'}
    return

  if not Array.isArray(board)
    callback {changed: false, reason: 'board is not an array'}
    return
  
  if not (Masu.isValid(sasite.masu.before) and Masu.isValid(sasite.masu.after))
    callback {changed: false, reason: 'sasite.masu is invalid'}
    return

  if sasite.masu.before == sasite.masu.after
    callback {changed: false, reason: 'sasite is identical'}
    return

  # beforeがあるかチェック
  __before = _.find board, (factor) ->
    sasite.masu.before is factor.masu and
      sasite.koma is factor.koma and
      sasite.sengo is factor.sengo
  
  if not __before?
    callback {changed: false, reason: 'sasite.before is not found in board'}
    return

  __before = undefined

  # 動きチェック
  sengo = sasite.sengo
  koma = sasite.koma
  before = sasite.masu.before
  after = sasite.masu.after

isValidMove = (koma, before, after) ->
  switch koma
    when Koma.HI
        


