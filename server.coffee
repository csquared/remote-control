express = require 'express'
sio     = require 'socket.io'
volume  = require './volume'

app = express()

app.configure () ->
  app.use(express.bodyParser())
  app.use(express.static('./public'))
  app.use(express.logger())

app.get '/', volume.index
app.get '/set/:volume', volume.set
app.get '/set', volume.set

volume.set_volume 50

server = app.listen(process.env.PORT || 3000)

io = sio.listen(server)

io.sockets.on 'connection', (socket) ->
  console.log 'Someone Connected'

  socket.on "volume", (text) ->
    socket.emit("set-volume", volume.set_volume(text))
    socket.broadcast.emit("set-volume", volume.set_volume(text))
