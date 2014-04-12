
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{Space} = require './spaces'
{bg} = require './bg'
{imgs} = require './image'

exports.paper =
  init: (state) ->
    @setState()
    @addSpaces()
    @configSpaces()
    @resize state

  resize: (state) ->
    canvas.style.width = "#{innerWidth}px"
    canvas.style.height = "#{innerHeight}px"
    console.log 'resize'
    @renderFrame state

  addSpaces: ->
    @spaces = []
    for x in [-2..2]
      for y in [-2..2]
        space = new Space
          x: x
          y: y
          img:
            x: imgs.fg.width
            y: imgs.fg.height
        @spaces.push space
    bg.init
      img:
        x: imgs.bg.width
        y: imgs.bg.height

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
      console.log 'animate end'
    , @duration

  renderFrame: ->
    @renderSpaces()
    @renderWallpaper()

  renderSteps: (newState) ->
    startTime = (new Date).valueOf()
    do loopRender = =>
      return unless @inSteps
      now = (new Date).valueOf()
      ratio = (now - startTime) / 400
      @renderSpacesAt ratio
      @renderWallpaperAt ratio
      requestAnimationFrame(loopRender)

  locate: (location) ->
    x: 0
    y: 0

  renderSpaces: ->
    for space in @spaces
      d = space.getDetail()
      context.drawImage imgs.fg,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,
        d.img.x, d.img.y, d.img.w, d.img.h,

  renderWallpaper: ->
    d = bg.getDetail()
    context.drawImage imgs.bg,
      d.bg.x, d.bg.y, d.bg.w, d.bg.h,
      d.img.x, d.img.y, d.img.w, d.img.h,

  renderSpacesAt: (ratio) ->
    for space in @spaces
      d = space.getDetailAt ratio
      context.drawImage imgs.fg,
        d.fg.x, d.fg.y, d.fg.w, d.fg.h,
        d.img.x, d.img.y, d.img.w, d.img.h,

  renderWallpaperAt: (ratio) ->
    d = bg.getDetailAt ratio
    context.drawImage imgs.bg,
      d.bg.x, d.bg.y, d.bg.w, d.bg.h,
      d.img.x, d.img.y, d.img.w, d.img.h,