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

  emit_all = (channel, text = null) ->
    socket.emit(channel, text)
    socket.broadcast.emit(channel, text)

  socket.on "volume", (text) ->
    controls.volume.set_volume text
    emit_all 'set-volume', text

  socket.on "pause", () ->
    controls.pause()
    emit_all 'play-pause'

  socket.on "play", () ->
    controls.play()
    emit_all 'play-pause'
