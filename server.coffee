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
      rdio_state: controls.rdio.state
      quicktime_state: controls.quicktime.state

# set volume to a known level
# ie: the barber shaves himself
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
    emit_all 'set-volume', controls.volume.current_volume()

  socket.on "pause-rdio", () ->
    controls.rdio.pause()
    emit_all 'toggle', 'rdio', controls.rdio.state

  socket.on "play-rdio", () ->
    controls.rdio.play()
    emit_all 'toggle', 'rdio', controls.rdio.state

  socket.on 'toggle', (app) ->
    controls.toggle(app)
    emit_all 'toggle', app, controls[app].state
