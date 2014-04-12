
{at} = require './tween'

exports.bg =
  init: (config) ->
    @img = config.img

  config: (position) ->
    @position = position
    @calculate()

  calculate: ->
    @oldDetail = @detail
    @detail =
      img:
        x: 0
        y: 0
        w: 0
        h: 0
      bg:
        x: 0
        y: 0
        w: 0
        h: 0

  getDetailAt: (ratio) ->
    bg: at @oldDetail.bg, @detail.bg, ratio
    img: at @oldDetail.bg, @detail.bg, ratio

  getDetail: ->
    @detail