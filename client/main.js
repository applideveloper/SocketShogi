//require(['app', 'views/waitgame', 'socket', 'backbone', 'jquery', 'jquerymobile'], function(app, WaitgameView, socket, Backbone, $) {
require(['app', 'views/waitgame', 'socket', 'backbone', 'jquery'], function(app, WaitgameView, socket, Backbone, $) {
  $(function() {
    app.render(new WaitgameView());
  });
});
