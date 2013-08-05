_ = require('../lib/underscore')

describe 'underscore', ->
  describe 'isEqualAsSet', ->
    it '[], [] => true', ->
      _.isEqualAsSet([], []).should.be.true
    it '[false], [false] => true', ->
      _.isEqualAsSet([false], [false]).should.be.true
    it '[1, 2], [1, 2] => true', ->
      _.isEqualAsSet([1, 2], [1, 2]).should.be.true
    it '[1, "2", false, 0], ["2", 0, 1, false] => true', ->
      _.isEqualAsSet([1, "2", false, 0], ["2", 0, 1, false]).should.be.true
    it '[0, {a: {b: "1"}}], [{a: {b: "1"}}, 0] => true', ->
      _.isEqualAsSet([0, {a: {b: "1"}}], [{a: {b: "1"}}, 0]).should.be.true
    it '[false], [] => false', ->
      _.isEqualAsSet([false], []).should.be.false
    it '[], [1] => false', ->
      _.isEqualAsSet([], [1]).should.be.false
    it '[1], [] => false', ->
      _.isEqualAsSet([1], []).should.be.false
    it '[1, 2, 3], [2, 4, 1] => false', ->
      _.isEqualAsSet([1, 2, 3], [2, 4, 1]).should.be.false
    it '[1, 2], ["1", 2] => false', ->
      _.isEqualAsSet([1, 2], ["1", 2]).should.be.false
    it '(none) => false', ->
      _.isEqualAsSet().should.be.false
    it 'null, [] => false', ->
      _.isEqualAsSet(null, []).should.be.false
    it '[], (undefined) => false', ->
      _.isEqualAsSet([]).should.be.false
      
