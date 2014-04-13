
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{Space} = require './spaces'
{bg} = require './bg'
{imgs} = require './image'
{hintLayer} = require './hint'

hintStyle = '#da4'
hintOpacity = 0.7
imgOpacity = 0.9

exports.paper =
  init: (state) ->
    @setState()
    @addSpaces state
    @configSpaces state
    @resize state

  resize: (state) ->
    @reClipSpaces()
    @configSpaces state
    canvas.setAttribute 'width', innerWidth
    canvas.setAttribute 'height', innerHeight
    @renderFrame state

  addSpaces: (state) ->
    @spaces = []
    for x in [-2..2]
      for y in [-2..2]
        space = new Space
          x: x
          y: y
          img:
            w: imgs.fg.width
            h: imgs.fg.height
        @spaces.push space
    bg.init
      img:
        w: imgs.bg.width
        h: imgs.bg.height

  configSpaces: (state) ->
    for space in @spaces
      space.config state
    bg.config state
    hintLayer.config state

  reClipSpaces: ->
    for space in @spaces
      space.makeClip()

  setState: ->
    @inSteps = no
    @duration = 400

  render: (state) ->
    @configSpaces state
    @renderFrame()

  animate: (state, callback) ->
    @inSteps = yes
    @configSpaces state
    @renderSteps state
    self = @
    setTimeout ->
      self.inSteps = no
      callback()
      self.renderFrame()
      console.log 'animate end'
    , @duration

  renderFrame: ->
    @renderWallpaper()
    @renderHint()
    @renderSpaces()

  renderSteps: (newState) ->
    startTime = (new Date).valueOf()
    do loopRender = =>
      return unless @inSteps
      now = (new Date).valueOf()
      ratio = (now - startTime) / 400
      @renderWallpaperAt ratio
      @renderSpacesAt ratio
      @renderHintAt ratio
      requestAnimationFrame(loopRender)

  locate: (point) ->
    console.log point
    for space in @spaces
      if space.contains point
        ret =
          x: space.x
          y: space.y
        return ret

  renderSpaces: ->
    for space in @spaces
      d = space.getDetail()
      context.globalAlpha = imgOpacity
      context.drawImage imgs.fg,
        d.img.x, d.img.y, d.img.w, d.img.h,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,

  renderWallpaper: ->
    d = bg.getDetail()
    context.clearRect 0, 0, innerWidth, innerHeight
    context.drawImage imgs.bg,
      d.img.x, d.img.y, d.img.w, d.img.h,
      0, 0, innerWidth, innerHeight

  renderHint: ->
    for space in @spaces
      if space.isActive()
        {hint} = hintLayer.getDetail()
        context.fillStyle = hintStyle
        context.globalAlpha = hintOpacity
        context.fillRect hint.x, hint.y, hint.w, hint.h

  renderSpacesAt: (ratio) ->
    for space in @spaces
      d = space.getDetailAt ratio
      context.globalAlpha = imgOpacity
      context.drawImage imgs.fg,
        d.img.x, d.img.y, d.img.w, d.img.h,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,

  renderWallpaperAt: (ratio) ->
    d = bg.getDetailAt ratio
    context.clearRect 0, 0, innerWidth, innerHeight
    context.drawImage imgs.bg,
      d.img.x, d.img.y, d.img.w, d.img.h,
      0, 0, innerWidth, innerHeight,

  renderHintAt: (ratio) ->
    for space in @spaces
      if space.isActive()
        {hint} = hintLayer.getDetailAt ratio
        context.fillStyle = hintStyle
        context.globalAlpha = hintOpacity
        context.fillRect hint.x, hint.y, hint.w, hint.h
