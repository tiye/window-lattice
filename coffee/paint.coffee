
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{Space} = require './spaces'
{bg} = require './bg'
{imgs} = require './image'

exports.paper =
  init: (state) ->
    @setState()
    @addSpaces state
    @configSpaces state
    @resize state

  resize: (state) ->
    canvas.setAttribute 'width', innerWidth
    canvas.setAttribute 'height', innerHeight
    console.log 'resize'
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

  setState: ->
    @inSteps = no
    @duration = 400

  render: (state) ->
    @configSpaces state
    @renderFrame()

  animate: (state, callback) ->
    @inSteps = yes
    @configSpaces state
    @renderSteps @oldState
    self = @
    setTimeout ->
      self.inSteps = no
      callback()
      self.renderWallpaper()
      self.renderSpaces()
      console.log 'animate end'
    , @duration

  renderFrame: ->
    @renderWallpaper()
    @renderSpaces()

  renderSteps: (newState) ->
    startTime = (new Date).valueOf()
    do loopRender = =>
      return unless @inSteps
      now = (new Date).valueOf()
      ratio = (now - startTime) / 400
      @renderWallpaperAt ratio
      @renderSpacesAt ratio
      requestAnimationFrame(loopRender)

  locate: (location) ->
    x: 0
    y: 0
    level: 1

  renderSpaces: ->
    for space in @spaces
      d = space.getDetail()
      context.drawImage imgs.fg,
        d.img.x, d.img.y, d.img.w, d.img.h,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,

      console.log d.fg

  renderWallpaper: ->
    d = bg.getDetail()
    context.clearRect 0, 0, innerWidth, innerHeight
    context.drawImage imgs.bg,
      d.img.x, d.img.y, d.img.w, d.img.h,
      0, 0, innerWidth, innerHeight

  renderSpacesAt: (ratio) ->
    for space in @spaces
      d = space.getDetailAt ratio
      context.drawImage imgs.fg,
        d.img.x, d.img.y, d.img.w, d.img.h,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,

  renderWallpaperAt: (ratio) ->
    d = bg.getDetailAt ratio
    context.clearRect 0, 0, innerWidth, innerHeight
    context.drawImage imgs.bg,
      d.img.x, d.img.y, d.img.w, d.img.h,
      0, 0, innerWidth, innerHeight,