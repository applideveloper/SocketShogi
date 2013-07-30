({
  baseUrl: 'client',
  paths: {
    requirejs: 'lib/require',
    jquery: 'lib/jquery-2.0.3',
    underscore: 'lib/underscore',
    backbone: 'lib/backbone',
    //underscore: 'lib/underscore-min',
    //backbone: 'lib/backbone-min',
    socketio: '../node_modules/socket.io/node_modules/socket.io-client/dist/socket.io'
  },
  shim: {
    jquery: {
      exports: 'jQuery'
    },
    underscore: {
      exports: '_'
    },
    backbone: {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    },
  },
  include: [
    'requirejs'
  ],
  name: 'main',
  out: 'public/dist/product.js'
})
