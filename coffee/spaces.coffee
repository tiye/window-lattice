
{at} = require './tween'
{clipSpace} = require './algorithm'

exports.Space = class
  constructor: (config) ->
    @img = config.img
    @x = config.x
    @y = config.y
    @clip = config.clip

  config: (position) ->
    @position = position
    @calculate()

  calculate: ->
    @oldDetail = @detail
    windou = w: innerWidth, h: innerHeight
    position = x: @x, y: @y
    @detail =
      img: @clip
      fg: clipSpace @img, position, windou

  getDetailAt: (ratio) ->
    fg: at @oldDetail.fg, @detail.fg, ratio
    img: @clip

  getDetail: ->
    @detail