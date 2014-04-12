
{at} = require './tween'

exports.Space = class
  constructor: (config) ->
    @img = config.img
    @x = config.x
    @y = config.y

  config: (position) ->
    @position = position
    @calculate()

  update: (config) ->
    @old =
      img: @img
      x: @x
      y: @y
      level: @level
    @config config

  calculate: ->
    @oldDetail = @detail
    @detail =
      img:
        x: 0
        y: 0
        w: 0
        h: 0
      fg:
        x: 0
        y: 0
        w: 0
        h: 0

  getDetailAt: (ratio) ->
    fg: at @oldDetail.fg, @detail.fg, ratio
    img: at @oldDetail.fg, @detail.fg, ratio

  getDetail: ->
    @detail