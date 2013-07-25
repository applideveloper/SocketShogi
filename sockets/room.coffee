module.exports = (io) ->
  nsFront = io.of('/front')
  nsFront.on 'connection', (socket) ->
    
    socket.on 'join', (room) ->
      # TODO
      nsFront.emit 'changed', room
  
    socket.on 'exit', (room) ->
      # TODO
      if room.
        nsFront.emit 'deleted', room
      else
        nsFront.emit 'changed', room

    socket.on 'create', (newRoom) ->
      nsFront.emit 'created', newRoom
