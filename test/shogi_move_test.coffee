assert = require('assert')
consts = require('../lib/consts')

describe 'move', ->
  describe '初期局面から', ->
    board = consts.initBoard()
    it '76歩'
