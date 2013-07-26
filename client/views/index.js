define(['app', 'socket', 'backbone', 'underscore'], function(app, socket, Backbone, _) {
  var IndexView = Backbone.View.extend({
    initialize: function() {

      socket.on('board changed', function(board) {
        console.log('board changed');
        console.log(board);
      });
      socket.emit('move', {masu: {before: 77, after: 76}, koma: 1, sengo: 101});

    },
    
    render: function() {
      this.$el.html(pre.index());
    },

  });

  return IndexView;

});
