
{at} = require './tween'
{putHint} = require './algorithm'

exports.hintLayer =
  init: (config) ->
    @img = config.img

  config: (state) ->
    @state = state
    @calculate()

  calculate: ->
    @oldDetail = @detail
    windou = w: innerWidth, h: innerHeight
    @detail =
      hint: putHint @state, windou

  getDetailAt: (ratio) ->
    hint: at @oldDetail.hint, @detail.hint, ratio

  getDetail: ->
    @detail
