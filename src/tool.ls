
define !(require, exports) ->

  exports.log = (...args) ->
    console.log.apply console, args