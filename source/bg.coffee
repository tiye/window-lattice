
{at} = require './tween'
{clipWallpaper} = require './algorithm'

exports.bg =
  init: (config) ->
    @img = config.img

  config: (position) ->
    @position = position
    @calculate()

  calculate: ->
    @oldDetail = @detail
    console.log @img, @position
    windou = w: innerWidth, h: innerHeight
    @detail =
      img: clipWallpaper @img, @position, windou

  getDetailAt: (ratio) ->
    # return @detail
    img: at @oldDetail.img, @detail.img, ratio

  getDetail: ->
    @detail