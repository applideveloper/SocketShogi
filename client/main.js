require(['app', 'views/index', 'socket', 'backbone', 'jquery'], function(app, IndexView, socket, Backbone, $) {
  $(function() {
    app.render(new IndexView());
  });
});
