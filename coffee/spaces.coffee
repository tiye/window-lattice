
exports.Space = class
  constructor: ->

  setup: (config) ->
    @img = config.img
    @screen = config.screen
    @x = config.x
    @y = config.y
    @level = config.level