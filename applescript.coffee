spawn   = require("child_process").spawn

exports.run = (applescript) ->
  run = spawn 'osascript'
  run.stderr.on 'data', (data) ->
    process.stdout.write("osascript STDERR #{data}")
  run.on 'exit', (code) ->
    console.log("osascript #{code}")
  run.stdin.write applescript
  run.stdin.end()
