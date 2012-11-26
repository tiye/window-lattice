
define !(require, exports) ->

  {tmpl} = require \./tmpl
  $ = require \jquery

  exports.draw-console = ->
    $ \#console .hide!

    json =
      "textarea/text": "Demo in Terminal"
    input = $ tmpl json

    $ \#console .append input
    {log} = require \./tool
    # $ \#console .fade-in!

    $("body").keypress (e) ->
      log e.key-code
      if e.ctrl-key and (not e.alt-key)

        if e.key-code is 2
          unless window.at-console then $ \#console .fade-in!
          else $ \#console .fade-out!
          window.at-console := not window.at-console

          log "ok"