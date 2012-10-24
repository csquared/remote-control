ascript = require './applescript'

exports.volume = require './volume'

exports.play= () ->
  ascript.run """
if appIsRunning("Rdio") then
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Play" of menu "Controls" of menu bar 1
end tell
end if

on appIsRunning(appName)
tell application "System Events" to (name of processes) contains appName
end appIsRunning
  """

exports.pause = () ->
  ascript.run """
if appIsRunning("Rdio") then
tell application "System Events"
tell application "Rdio" to activate
tell process "Rdio" to click menu item "Pause" of menu "Controls" of menu bar 1
end tell
end if

on appIsRunning(appName)
tell application "System Events" to (name of processes) contains appName
end appIsRunning
  """
