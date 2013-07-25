exports.Sengo =
  SENTE: 101
  GOTE: 102

exports.Masu =
  KOMADAI: 0

exports.Koma =
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

