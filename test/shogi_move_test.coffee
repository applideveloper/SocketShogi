assert = require('assert')
consts = require('../lib/consts')
Koma = consts.Koma

describe 'no_rule', ->
  moveNorule = require('../lib/move/norule')
  describe '初期局面から', ->
    board = consts.initBoard()
    it '76歩', ->
      
      #aBoard = _.reject consts.initBoard(), (factor) ->
      #  factor.masu == 77
      #aBoard.push {Koma: 76, 

