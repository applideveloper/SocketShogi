// 仮ですが、
// AppViewはシングルトンで、
// このモジュールはAppViewのインスタンスを返します。

define(['backbone'], function(Backbone) {
  var AppView = Backbone.View.extend({
    el: 'body',
    
    modal: null,

    initialize: function() {

    },

    render: function(view) {
      view.render();
      this.$('#main').html(view.el);
      return this;
    },

    renderModal: function(modalView) {
      modalView.render();
      this.modal = modalView;
      this.$el.find('#modal').html(modalView.el);
      return this;
    },
    
    closeModal: function() {
      this.modal = null;
      this.$('#modal').html('');
    },

  });

  var app;
  if (!app) app = new AppView();
  return app;
});
