
###
Module dependencies.
###
express = require('express')
routes = require('./routes')
http = require('http')
path = require('path')
app = express()

# all environments
app.set 'port', process.env.PORT or 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser('your secret here')
app.use express.session()
app.use app.router
app.use require('stylus').middleware(__dirname + '/public')
app.use express.static(path.join(__dirname, 'public'))

# development only
app.use express.errorHandler()  if 'development' is app.get('env')


app.get '/', routes.index

server = http.createServer(app)
io = require('socket.io').listen(server)
  

#require('./controller/solo').init(app)

require('./sockets/shogi')(io)

server.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
