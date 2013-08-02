module.exports =
  KOMADAI: 0
  # マスとして正しい値かどうかを判定
  isValid: (masu) ->
    return true if masu is this.KOMADAI
    # 11~99 ただし20とかはだめ
    masu is masu | 0 and masu % 10 isnt 0 and 11 <= masu and masu <= 99
