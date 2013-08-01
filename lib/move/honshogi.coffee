_ = require('underscore')

consts = require('/lib/consts')
Masu = require('lib/masu')
Koma = require('/lib/koma')
Sengo = consts.Sengo

# board: Board
# sasite: {masu: {before: Number, after: Number}, koma: Number, sengo: Number, nari: Boolean[非必須]}

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

  # afterに自分の駒がないかチェック
  __after = _.find board, (factor) ->
    sasite.masu.after is factor.masu and sasite.sengo is factor.sengo
  if __after?
    callback {changed: false, reason: 'sasite.after の場所に自分の駒がいます'}
    return

  sengo = sasite.sengo
  koma = sasite.koma
  before = sasite.masu.before
  after = sasite.masu.after

  # 動きチェック
  if not isValidMove(koma, before, after, sengo) ->
    callback {changed: false, reason: 'sasite move is not valid'}
    return

  # 行きどころ
  if not sasite.nari and not hasIkidokoro(koma, after, sengo) ->
    callback {changed: false, reason: '行きどころのない駒'}
    return

  # 成りチェック
  if sasite.nari and not canNari(koma, before, after, sengo) ->
    callback {changed: false, reason: '成ろうとしてるけど成れない'}
    return

  # 竜馬角飛香の間に駒がないか
  if before isnt Masu.KOMADAI and ~[Koma.RYU, Koma.UMA, Koma.HI, Koma.KAKU, Koma.KYO].indexOf(koma)
    # 縦横をとっとく
    beforeX = before / 10 | 0 , beforeY = before % 10
    afterX = after / 10 | 0, afterY = after % 10
  
    diffX = afterX - beforeX
    diffY = afterY - beforeY

    # 方向 1,-1,0のどれか
    directX = if diffX then diffX/Math.abs(diffX) else 0
    directY = if diffY then diffY/Math.abs(diffY) else 0

    # 1こ動かす
    tmpX = beforeX + directX, tmpY = beforeY + directY
    # 1こで終わりならOK
    while tmpX isnt afterX and tmpY isnt afterY
      if (_.find board, (factor) -> tmp is factor.masu) ?
        callback {changed: false, reason: '間に駒がはさまってる'}
        return
      tmpX += directX, tmpY += directY
      # TODO 無限ループにはならないはずだが、念のためチェックが必要か？


isValidMove = (koma, before, after, sengo) ->
  if not sengo? or not Sengo.isValid(sengo)
    console.log '先後指定してないよ'
    return false

  return false if before = after
  return false if after is Masu.KOMADAI
  return true if before is Masu.KOMADAI

  # 後手の指手の場合、ひっくり返す
  # 例 28 => 82
  if sengo is Sengo.GOTE
    before = 110 - before
    after = 110 - after
  
  # 縦横をとっとく
  beforeX = before / 10 | 0 , beforeY = before % 10
  afterX = after / 10 | 0, afterY = after % 10
  
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

# 行きどころのある駒
hasIkidokoro = (koma, after, sengo) ->
  if not sengo? or not Sengo.isValid(sengo)
    console.log '先後指定してないよ'
    return false

  afterY = after % 10
  afterY = 10 - afterY if sengo is Sengo.GOTE

  switch koma
    when Koma.KEI
      afterY isnt 2 and afterY isnt 1
    when Koma.KYO, Koma.FU
      afterY isnt 1
    else true

# なれるか
canNari = (koma, before, after, sengo) ->
  if not sengo? or not Sengo.isValid(sengo)
    console.log '先後指定してないよ'
    return false
  return false if before is Koma.KOMADAI
  return false if not Koma.canNari(koma)

  beforeY = before % 10, afterY = after % 10
  if sengo is Sengo.GOTE
    beforeY = 10 - beforeY
    afterY = 10 - afterY

  afterY <= 3 or beforeY <= 3

