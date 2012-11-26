
define !(require, exports) ->

  {tmpl} = require \./tmpl
  window.$ = $ = require \jquery
  {log} = require \./tool
  window.ls = ls = require \./livescript-1.1.0.js .LiveScript
  log ls

  exports.draw-console = ->
    $ \#console .hide!

    json =
      "textarea/text": "Demo in Terminal"
    input = $ tmpl json

    $ \#console .append input

    $("body").keypress (e) ->
      # log e.key-code
      if e.ctrl-key and (not e.alt-key)

        if e.key-code is 2
          unless window.at-console
            $ \#console .fade-in!
            text-elem = input.0
            text-length = text-elem.value.length
            # log \length text-length, text-elem
            text-elem.selection-start = text-length
            text-elem.selection-end = text-length
          else $ \#console .fade-out!
          window.at-console := not window.at-console

          # log "ok"
    log "binding key"
    input.keydown (e) ->
      # log e.key-code
      if e.ctrl-key and (not e.alt-key)

        if e.key-code is 13

          code = input.val!
          log code
          try ls.run code
          catch err then show-error err

    show-error = (info) ->
      log info