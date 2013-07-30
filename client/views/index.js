define(['backbone'], function(Backbone) {
  var IndexView = Backbone.View.extend({
    initialize: function() {

    },
    
    render: function() {
      this.$el.html(pre.index());
    },

  });

  return IndexView;

});
