ascript = require './applescript'

@volume = 0

exports.set_volume = (volume, socket) =>
  @volume = parseInt(volume)
  @volume = 0 if @volume < 0
  @volume = 100 if @volume > 100
  applescript = "set volume output volume #{@volume}"
  ascript.run applescript
  @emit(socket, 'set-volume', @volume) if socket
  return @volume

exports.current_volume = () => @volume

exports.emit = (socket, name, text) ->
  socket.emit(name, @set_volume(text))
  socket.broadcast.emit(name, @set_volume(text))
