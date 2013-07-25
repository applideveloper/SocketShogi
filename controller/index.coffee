routes = require('../routes')

module.exports = (app) ->
  app.get '/', routes.index
  app.get '/rooms', routes.rooms.index
  app.post '/rooms', routes.rooms.create
  app.get '/rooms/:roomId', routes.rooms.show

