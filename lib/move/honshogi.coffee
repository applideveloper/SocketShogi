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

isValidMove = (koma, before, after, sengo) ->
  if not sengo?
    console.log '先後指定してないよ'
    return false

  return false if before = after
  return false if after is Masu.KOMADAI

  # 後手の指手の場合、ひっくり返す
  # 例 28 => 82
  if not sengo
    before = 110 - before
    after = 110 - after
  
  # 縦横をとっとく
  beforeX = before / 10 | 0 , beforeY = before % 10
  afterX = after / 10 | 0, afterY = after % 10
  
  if before is Masu.KOMADAI

    ###
    switch koma
      when Koma.KEI
        return afterX isnt 2 and afterX isnt 1
      when Koma.KYO, Koma.FU
        return afterX isnt 1
      else return true
    ###

  # 右・上が＋
  diffX = beforeX - afterX #右
  diffY = beforeY - afterY #上

  # 以降,return
  switch koma
    when Koma.OU
      -1 <= diffX and diffX <= 1 and -1 <= diffY and diffY <= 1
    when Koma.RYU
      beforeX is afterX or beforeY is afterY or (Math.abs(diffX) is 1 and Math.abs(diffY) is 1)
    when Koma.HI
      beforeX is afterX or beforeY is afterY
    when Koma.UMA
      Math.abs(diffX) is Math.abs(diffY) or Math.abs(diffX) + math.abs(diffY) is 1
    when Koma.KAKU
      Math.abs(diffX) is Math.abs(diffY)
    when Koma.KIN, Koma.NGIN, Koma.NKEI, Koma.NKYO, Koma.TO
      if diffY is 1 or diffY is 0
        diffX is 1 or diffX is -1 or diffX is 0
      else if diffY is -1
        diffX is 0
      else false
    when Koma.GIN
      if diffY is 1
        diffX is 1 or diffX is -1 or diffX is 0
      else if diffY is -1
        diffX is 1 or diffX is -1
      else false
    when Koma.KEI
      diffY is 2 and Math.abs(diffX) is 1
    when Koma.KYO
      beforeX is afterX and diffY > 0
    when Koma.FU
      beforeX is afterX and diffY is 1


