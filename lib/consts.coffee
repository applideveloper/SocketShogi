exports.Sengo = Sengo =
  SENTE: 101
  GOTE: 102

exports.Masu =
  KOMADAI: 0

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
  RYU: 14
  RYUOU: 14
  UMA: 13
  RYUME: 13
  NGIN: 12
  NKEI: 11
  NKYO: 10
  TO: 9
  NFU: 9


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
_.each(_.range(1,10), (num) ->
  factors.push { koma: this.Koma.FU, sengo: this.Sengo.SENTE, masu: num * 10 + 7 }
  factors.push { koma: this.Koma.FU, sengo: this.Sengo.GOTE, masu: num * 10 + 3 }
factors.push(
  { koma: this.Koma.OU, sengo: this.Sengo.SENTE, masu: 59 } ,
  { koma: this.Koma.OU, sengo: this.Sengo.GOTE, masu: 51 } ,
  { koma: this.Koma.HI, sengo: this.Sengo.SENTE, masu: 28 } ,
  { koma: this.Koma.HI, sengo: this.Sengo.GOTE, masu: 82 } ,
  { koma: this.Koma.KAKU, sengo: this.Sengo.SENTE, masu: 88 } ,
  { koma: this.Koma.KAKU, sengo: this.Sengo.GOTE, masu: 22 } ,
  { koma: this.Koma.KIN, sengo: this.Sengo.SENTE, masu: 69 } ,
  { koma: this.Koma.KIN, sengo: this.Sengo.SENTE, masu: 49 } ,
  { koma: this.Koma.KIN, sengo: this.Sengo.GOTE, masu: 41 } ,
  { koma: this.Koma.KIN, sengo: this.Sengo.GOTE, masu: 61 } ,
  { koma: this.Koma.GIN, sengo: this.Sengo.SENTE, masu: 79 } ,
  { koma: this.Koma.GIN, sengo: this.Sengo.SENTE, masu: 39 } ,
  { koma: this.Koma.GIN, sengo: this.Sengo.GOTE, masu: 31 } ,
  { koma: this.Koma.GIN, sengo: this.Sengo.GOTE, masu: 71 } ,
  { koma: this.Koma.KEI, sengo: this.Sengo.SENTE, masu: 89 } ,
  { koma: this.Koma.KEI, sengo: this.Sengo.SENTE, masu: 29 } ,
  { koma: this.Koma.KEI, sengo: this.Sengo.GOTE, masu: 21 } ,
  { koma: this.Koma.KEI, sengo: this.Sengo.GOTE, masu: 81 } ,
  { koma: this.Koma.KYO, sengo: this.Sengo.SENTE, masu: 99 } ,
  { koma: this.Koma.KYO, sengo: this.Sengo.SENTE, masu: 19 } ,
  { koma: this.Koma.KYO, sengo: this.Sengo.GOTE, masu: 11 } ,
  { koma: this.Koma.KYO, sengo: this.Sengo.GOTE, masu: 91 }
    

exports.initBoard = ->
  newFactors = []
  _.each factors, (factor) ->
    newFactors.push _.clone(factor)
  newFactors

