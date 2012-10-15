spawn   = require("child_process").spawn

@volume = 0

run_applescript = (applescript) ->
  run = spawn 'osascript'
  run.stderr.on 'data', (data) -> process.stdout.write("osascript STDERR #{data}")
  run.on 'exit', (code) -> console.log("osascript #{code}")
  run.stdin.write applescript
  run.stdin.end()

exports.set_volume = (volume) =>
  @volume = parseInt(volume)
  @volume = 0 if @volume < 0
  @volume = 100 if @volume > 100
  applescript = "set volume output volume #{@volume}"
  run_applescript applescript
  return @volume

exports.index = (req, res) =>
  res.render 'index.ejs',
    locals:
      volume: @volume

exports.set = (req, res) =>
  @set_volume req.param('volume') || 0
  res.redirect '/'
