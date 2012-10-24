ascript = require './applescript'

@volume = 0

exports.set_volume = (volume, socket) =>
  @volume = parseInt(volume)
  @volume = 0 if @volume < 0
  @volume = 100 if @volume > 100
  applescript = "set volume output volume #{@volume}"
  ascript.run applescript
  return @volume

exports.current_volume = () => @volume
