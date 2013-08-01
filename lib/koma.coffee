module.exports =
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
  
  isNarigoma: (koma) ->
    return true if ~[@RYU, @UMA, @NGIN, @NKEI, @NKYO, @TO].indexOf(koma)

  canNari: (koma) ->
    return true if ~[@HI, @KAKU, @GIN, @KEI, @KYO, @FU].indexOf(koma)
