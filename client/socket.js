define(['socketio'], function(io) {
  var socket;
  if (! socket) {
    socket = io.connect('/shogi');
  }
  return socket;
});
