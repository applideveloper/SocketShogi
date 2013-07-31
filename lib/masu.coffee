module.exports =
  KOMADAI: 0
  isValid: (masu) ->
    return true if masu is this.KOMADAI
    masu is masu | 0
      and masu % 10 isnt 0
      and 11 <= masu and masu <= 99
