ascript = require './applescript'

exports.volume = require './volume'

exports.play= (socket) ->
  ascript.run """
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Play" of menu "Controls" of menu bar 1
end tell
  """

exports.pause = (socket) ->
  ascript.run """
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Pause" of menu "Controls" of menu bar 1
end tell
  """
