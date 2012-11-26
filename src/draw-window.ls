
window.world = {}

define !(require, exports) ->
  $ = require "jquery"
  tmpl = require("./tmpl").tmpl
  {log} = require "./tool"

  w = window.inner-width
  h = window.inner-height
  overview-ratio = 0

  create-dekstop = (place, position) ->
    unless window.world[place]
      desktop = ($ tmpl ".desk": "desk")
      $ \#view .append desktop
      window.world[place] = {p: position, desktop}

  desktop-n = (n) ->
    [-n to n].for-each (y) ->
      [-n to n].for-each (x) ->
        place = "#y&#x"
        position = {x, y}
        create-dekstop place, position

  exports.draw-window = ->

    for n in [0 to 3]
      desktop-n n

    exports.resize-window!

    $("body").keypress (e) ->
      log e.key-code
      if e.ctrl-key and (not e.alt-key)

        if window.at-console?

          if (e.key-code is 17)
            unless window.at-view
              $ \#view .css \-webkit-transform "scale(0.92)"
            else $ \#view .css \-webkit-transform "scale(1)"
            window.at-view := not window.at-view

          else if (e.key-code is 13)
            unless window.at-overview
              $ \#overview .css \-webkit-transform "scale(#overview-ratio)"
            else $ \#overview .css \-webkit-transform "scale(1)"
            window.at-overview := not window.at-overview

  exports.resize-window = ->

    w := window.inner-width
    h := window.inner-height

    desks = $ ".desk"
    desks.css width: "#{w}px"
    desks.css height: "#{h}px"

    $ \#view .css \-webkit-transform-origin "#{w/2}px #{h/2}px"
    $ \#overview .css \-webkit-transform-origin "#{w/2}px #{h/2}px"

    count-desktop = 0

    for key, obj of world
      {p, desktop} = obj
      desktop.css \left "#{p.x * w * 1.02}px"
      desktop.css \top "#{p.y * h * 1.02}px"
      # log p.x, p.y
      count-desktop += 1

    size = Math.sqrt count-desktop
    overview-ratio := 1 / (size - 2) / 1.02