_ = require('underscore')

_.mixin isEqualAsSet: (array, other) ->
  return false if not (_.isArray(array) and _.isArray(other) and array.length is other.length)
  ary1 = _.clone array
  ary2 = _.clone other
  until _.isEmpty ary1 #or _isEmpty ary2
    tmp = ary1[0]
    # 削除
    ary1.splice 0,1

    # coffeescriptにはラベルがないらしいので仕方なく。。
    found = false
    for elem, index in ary2
      if _.isEqual tmp, elem
        #ary2からも削除
        ary2.splice index, 1
        found = true
        break
    # 無ければfalse
    return false if not found
  # ary1,ary2ともに空になっているはず
  return true

console.log _.isEqualAsSet([], [])

module.exports = _
