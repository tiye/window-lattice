
define !(require, exports) ->

  {draw-window, resize-window} = require "./draw-window"
  {draw-console} = require "./draw-console"

  draw-window!
  draw-console!
  window.onresize = resize-window

  window.at-view = no
  window.at-overview = no
  window.at-console = no