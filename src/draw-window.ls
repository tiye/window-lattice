
window.world = {}
window.current = "0_0"

define !(require, exports) ->
  $ = require "jquery"
  tmpl = require("./tmpl").tmpl
  {log} = require "./tool"

  w = window.inner-width
  h = window.inner-height
  overview-ratio = 1
  view-ratio = 1

  create-dekstop = (place, position) ->
    unless window.world[place]
      {x,y} = position
      name = "#{x}_#{y}"
      desktop = ($ tmpl ".desk/#{name}": {".name": name})
      $ \#view .append desktop
      window.world[place] = {p: position, desktop}
      $ "\##name" .click -> move-to "#{-x}_#{-y}"

  desktop-n = (n) ->
    [-n to n].for-each (y) ->
      [-n to n].for-each (x) ->
        place = "#{x}_#{y}"
        position = {x, y}
        # log place
        create-dekstop place, position

  get-left = (elem) ->
    left = (elem.css \left) - "px"
    (Number left) or 0

  get-top = (elem) ->
    top = (elem.css \top) - "px"
    (Number top) or 0

  window.move-to = move-to = (name) ->
    log \name name
    if window.world[name]?
      {x,y} = window.world[name].p
      $ \#view .css \left (x * w * view-ratio * 1.02)
      $ \#view .css \top (y * h * view-ratio * 1.02)
      window.current = name

  window.move-left = move-left = ->  
    {x, y} = window.world[window.current].p
    move-to "#{x+1}_#{y}"

  window.move-right = move-right = ->
    {x, y} = window.world[window.current].p
    move-to "#{x-1}_#{y}"

  window.move-up = move-up = ->
    {x, y} = window.world[window.current].p
    move-to "#{x}_#{y-1}"

  window.move-down = move-down = ->
    {x, y} = window.world[window.current].p
    move-to "#{x}_#{y+1}"

  window.toggle-view = toggle-view = ->
    unless window.at-view
      $ \#view .css \-webkit-transform "scale(0.92)"
      view-ratio := 0.92
      move-to window.current
    else
      $ \#view .css \-webkit-transform "scale(1)"
      view-ratio := 1
      move-to window.current
    window.at-view := not window.at-view

  window.toggle-overview = toggle-overview = ->
    unless window.at-overview
      $ \#overview .css \-webkit-transform "scale(#overview-ratio)"
    else $ \#overview .css \-webkit-transform "scale(1)"
    window.at-overview := not window.at-overview

  exports.draw-window = (size) ->

    [0 to size].for-each desktop-n

    exports.resize-window!

    $("body").keydown (e) ->
      # log e.key-code
      if e.ctrl-key and (not e.alt-key)
        unless window.at-console
          if (e.key-code is 81) then toggle-view!
          else if (e.key-code is 77) then toggle-overview!
          else if (e.key-code is 37) then move-left!
          else if (e.key-code is 39) then move-right!
          else if (e.key-code is 40) then move-up!
          else if (e.key-code is 38) then move-down!

  window.resize-desktop = (size) ->

    $ \#view .html ""
    window.world := {}
    [0 to size].for-each desktop-n
    exports.resize-window!

  exports.resize-window = ->

    w := window.inner-width
    h := window.inner-height

    desks = $ ".desk"
    desks.css width: "#{w}px"
    desks.css height: "#{h}px"

    left = (get-left ($ \#view)) + w/2*1.02
    top = (get-top ($ \#view)) + h/2*1.02
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