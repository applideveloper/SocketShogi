_ = require('underscore')

exports.Sengo = Sengo =
  SENTE: 101
  GOTE: 102

# deprecated. use lib/masu
exports.Masu =
  KOMADAI: 0
  isValid: (masu) ->
    return true if masu is this.KOMADAI
    masu is masu | 0
      and masu % 10 isnt 0
      and 11 <= masu and masu <= 99

# deprecated. use lib/koma
exports.Koma = Koma =
  OU: 8
  GYOKU: 8
  HI: 7
  KAKU: 6
  KIN: 5
  GIN: 4
  KEI: 3
  KYO: 2
  FU: 1
  HU: 1
  RYU: -7
  RYUOU: -7
  NHI: -7
  UMA: -6
  RYUME: -6
  NKAKU: -6
  NGIN: -4
  NKEI: -3
  NKYO: -2
  TO: -1
  NFU: -1


  nari: (koma) ->
    switch koma
      when @HI then @RYU
      when @RYU then @HI
      when @KAKU then @UMA
      when @UMA then @KAKU
      when @GIN then @NGIN
      when @NGIN then @GIN
      when @KEI then @NKEI
      when @NKEI then @KEI
      when @KYO then @NKYO
      when @NKYO then @KYO
      when @FU then @TO
      when @TO then @FU

factors = []
_.each _.range(1,10), (num) ->
  factors.push { koma: Koma.FU, sengo: Sengo.SENTE, masu: num * 10 + 7 }
  factors.push { koma: Koma.FU, sengo: Sengo.GOTE, masu: num * 10 + 3 }
factors.push(
  { koma: Koma.OU, sengo: Sengo.SENTE, masu: 59 } ,
  { koma: Koma.OU, sengo: Sengo.GOTE, masu: 51 } ,
  { koma: Koma.HI, sengo: Sengo.SENTE, masu: 28 } ,
  { koma: Koma.HI, sengo: Sengo.GOTE, masu: 82 } ,
  { koma: Koma.KAKU, sengo: Sengo.SENTE, masu: 88 } ,
  { koma: Koma.KAKU, sengo: Sengo.GOTE, masu: 22 } ,
  { koma: Koma.KIN, sengo: Sengo.SENTE, masu: 69 } ,
  { koma: Koma.KIN, sengo: Sengo.SENTE, masu: 49 } ,
  { koma: Koma.KIN, sengo: Sengo.GOTE, masu: 41 } ,
  { koma: Koma.KIN, sengo: Sengo.GOTE, masu: 61 } ,
  { koma: Koma.GIN, sengo: Sengo.SENTE, masu: 79 } ,
  { koma: Koma.GIN, sengo: Sengo.SENTE, masu: 39 } ,
  { koma: Koma.GIN, sengo: Sengo.GOTE, masu: 31 } ,
  { koma: Koma.GIN, sengo: Sengo.GOTE, masu: 71 } ,
  { koma: Koma.KEI, sengo: Sengo.SENTE, masu: 89 } ,
  { koma: Koma.KEI, sengo: Sengo.SENTE, masu: 29 } ,
  { koma: Koma.KEI, sengo: Sengo.GOTE, masu: 21 } ,
  { koma: Koma.KEI, sengo: Sengo.GOTE, masu: 81 } ,
  { koma: Koma.KYO, sengo: Sengo.SENTE, masu: 99 } ,
  { koma: Koma.KYO, sengo: Sengo.SENTE, masu: 19 } ,
  { koma: Koma.KYO, sengo: Sengo.GOTE, masu: 11 } ,
  { koma: Koma.KYO, sengo: Sengo.GOTE, masu: 91 }
)

exports.initBoard = ->
  newFactors = []
  _.each factors, (factor) ->
    newFactors.push _.clone(factor)
  newFactors

