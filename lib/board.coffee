Koma = require('./koma')
Sengo = require('./sengo')

exports.initBoard = ->
  factors = []
  for num in [1..9]
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
  factors


