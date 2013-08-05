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
      moveNorule initBoard, {masu: {before: 77, after: 76}, koma: Koma.FU, sengo: Sengo.SENTE} , (err, newBoard) ->
        should.not.exist err

        aBoard = _.reject initBoard, (factor) ->
          factor.masu == 77
        aBoard.push {masu: 76, koma: Koma.FU, sengo: Sengo.SENTE}
        _.isEqualAsSet(newBoard, aBoard).should.be.true

    it '初期局面から77歩=>76歩(後手) : false', ->
      moveNorule initBoard, {masu: {before: 77, after: 76}, koma: Koma.FU, sengo: Sengo.GOTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard

    it '初期局面から77歩=>77歩 : false', ->
      moveNorule initBoard, {masu: {before: 77, after: 77}, koma: Koma.FU, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard

    it '初期局面から11香=>55香', ->
      moveNorule initBoard, {masu: {before: 11, after: 55}, koma: Koma.KYO, sengo: Sengo.GOTE}, (err, newBoard) ->
        should.not.exist err

        aBoard = _.reject initBoard, (factor) ->
          factor.masu == 11
        aBoard.push {masu: 55, koma: Koma.KYO, sengo: Sengo.GOTE}
        _.isEqualAsSet(newBoard, aBoard).should.true

    it '初期局面から28飛=>88飛', ->
      moveNorule initBoard, {masu: {before: 28, after: 88}, koma: Koma.HI, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.not.exist err

        aBoard = _.reject initBoard, (factor) ->
          factor.masu == 28 or factor.masu == 88
        aBoard.push {masu: 88, koma: Koma.HI, sengo: Sengo.SENTE}
        aBoard.push {masu: Masu.KOMADAI, koma: Koma.KAKU, sengo: Sengo.SENTE}
        _.isEqualAsSet(newBoard, aBoard).should.true

    it '初期局面から76歩=>75歩', ->
      moveNorule initBoard, {masu: {before: 76, after: 75}, koma: Koma.FU, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard
      
describe '本将棋', ->
  moveHonshogi = require('../lib/move/honshogi')
  describe '初期局面から', ->
    initBoard = Board.initBoard()

    it '初期局面から77歩=>76歩', ->
      moveHonshogi initBoard, {masu: {before: 77, after: 76}, koma: Koma.FU, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.not.exist err
        aBoard = _.reject initBoard, (factor) ->
          factor.masu == 77
        aBoard.push {masu: 76, koma: Koma.FU, sengo: Sengo.SENTE}
        _.isEqualAsSet(newBoard, aBoard).should.true

    it '初期局面から後手73歩=>74歩', ->
      moveHonshogi initBoard, {masu: {before: 73, after: 74}, koma: Koma.FU, sengo: Sengo.GOTE}, (err, newBoard) ->
        should.not.exist err
        aBoard = _.reject initBoard, (factor) ->
          factor.masu == 73
        aBoard.push {masu: 74, koma: Koma.FU, sengo: Sengo.GOTE}
        _.isEqualAsSet(newBoard, aBoard).should.true

    it '初期局面から77歩=>75歩 : err', ->
      moveHonshogi initBoard, {masu: {before: 77, after: 75}, koma: Koma.FU, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard

    it '初期局面から88角=>55角 : err', ->
      moveHonshogi initBoard, {masu: {before: 88, after: 55}, koma: Koma.KAKU, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard

    it '初期局面から28飛=>68飛', ->
      moveHonshogi initBoard, {masu: {before: 28, after: 68}, koma: Koma.HI, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.not.exist err
        should.exist newBoard

    it '初期局面から28飛=>98飛 : err', ->
      moveHonshogi initBoard, {masu: {before: 28, after: 98}, koma: Koma.HI, sengo: Sengo.SENTE}, (err, newBoard) ->
        should.exist err
        should.not.exist newBoard
