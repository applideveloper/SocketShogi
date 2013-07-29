fs = require('fs')

### 
# @param {mode} mode of moving, 'norule' if omitted
# @param {board} Board
# @param {sasite} Sasite
# @param {callback} callback(info: {changed: Boolean, reason: String (if not changed)}, 
#  newBoard: Board (if changed) )
#
###

module.exports = (mode, board, sasite, callback) ->
  if _.isFunction(sasite)
    callback = sasite
    sasite = board
    board = mode
    mode = 'norule'
  
  path = './move' + mode
  fs.exists path, (exists) ->
    if not exists?
      callback {changed: false, reason: 'mode is invalid'}
      return
    move = require(path)
    move board, sasite, callback
    return
