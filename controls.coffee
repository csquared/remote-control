ascript = require './applescript'

exports.volume = require './volume'
exports.rdio = {state: 0}
exports.quicktime = {state: 0}

exports.rdio.play = () ->
  exports.rdio.state = 1
  ascript.run """
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Play" of menu "Controls" of menu bar 1
end tell
  """

exports.rdio.pause = () ->
  exports.rdio.state = 0
  ascript.run """
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Pause" of menu "Controls" of menu bar 1
end tell
  """

exports.toggle = (app) ->
  if app == 'quicktime'
    exports[app].state = if exports[app].state == 1 then 0 else 1
    ascript.run """
      tell application "QuickTime Player"
      if document 1 is playing then
      pause document 1
      else
      play document 1
      end if
      end tell
    """

ascript.run """
  tell application "QuickTime Player"
  if document 1 is playing then
  pause document 1
  end if
  end tell
"""
