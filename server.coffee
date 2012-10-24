express = require 'express'
sio     = require 'socket.io'
controls  = require './controls'

app = express()

app.configure () ->
  app.use(express.bodyParser())
  app.use(express.static('./public'))
  app.use(express.logger())


app.get '/', (req, res) =>
  res.render 'index.ejs',
    locals:
      volume: controls.volume.current_volume()

controls.volume.set_volume 50

server = app.listen(process.env.PORT || 3000)
io     = sio.listen(server)

io.sockets.on 'connection', (socket) ->
  console.log 'Someone Connected'

  socket.on "volume", (text) -> controls.volume.set_volume text, socket
  socket.on "pause", controls.pause
  socket.on "pause", controls.play
