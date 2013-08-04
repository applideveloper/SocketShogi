assert = require('assert')
should = require('should')

_ = require('../lib/underscore')

Masu = require('../lib/masu')
Koma = require('../lib/koma')
Sengo = require('../lib/sengo')
Board = require('../lib/board')

describe 'no_rule', ->
  moveNorule = require('../lib/move/norule')
  describe '初期局面から', ->
    initBoard = Board.initBoard()

    it '初期局面から77歩=>76歩', ->
      boardObj = moveNorule initBoard, {masu: {before: 77, after: 76}, koma: Koma.FU, sengo: Sengo.SENTE}
      boardObj.isValid.should.be.true

      aBoard = _.reject initBoard, (factor) ->
        factor.masu == 77
      aBoard.push {masu: 76, koma: Koma.FU, sengo: Sengo.SENTE}
      _.isEqualAsSet(boardObj.newBoard, aBoard).should.true

    it '初期局面から77歩=>76歩(後手) : false', ->
      boardObj = moveNorule initBoard, {masu: {before: 77, after: 76}, koma: Koma.FU, sengo: Sengo.GOTE}
      boardObj.isValid.should.be.false

    it '初期局面から77歩=>77歩 : false', ->
      boardObj = moveNorule initBoard, {masu: {before: 77, after: 77}, koma: Koma.FU, sengo: Sengo.SENTE}
      boardObj.isValid.should.be.false

    it '初期局面から11香=>55香', ->
      boardObj = moveNorule initBoard, {masu: {before: 11, after: 55}, koma: Koma.KYO, sengo: Sengo.GOTE}
      boardObj.isValid.should.be.true

      aBoard = _.reject initBoard, (factor) ->
        factor.masu == 11
      aBoard.push {masu: 55, koma: Koma.KYO, sengo: Sengo.GOTE}
      _.isEqualAsSet(boardObj.newBoard, aBoard).should.true

    it '初期局面から28飛=>88飛', ->
      boardObj = moveNorule initBoard, {masu: {before: 28, after: 88}, koma: Koma.HI, sengo: Sengo.SENTE}
      
      boardObj.isValid.should.be.true

      aBoard = _.reject initBoard, (factor) ->
        factor.masu == 28 or factor.masu == 88
      aBoard.push {masu: 88, koma: Koma.HI, sengo: Sengo.SENTE}
      aBoard.push {masu: Masu.KOMADAI, koma: Koma.KAKU, sengo: Sengo.SENTE}
      _.isEqualAsSet(boardObj.newBoard, aBoard).should.true

    it '初期局面から76歩=>75歩', ->
      boardObj = moveNorule initBoard, {masu: {before: 76, after: 75}, koma: Koma.FU, sengo: Sengo.SENTE}
      
      boardObj.isValid.should.be.false
