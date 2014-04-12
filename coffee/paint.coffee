
canvas = document.querySelector '#canvas'
context = canvas.getContext '2d'

{Space} = require './spaces'
{bg} = require './bg'
{imgs} = require './image'

exports.paper =
  init: (state) ->
    @spaces = []
    @setState()
    @addSpaces()
    @resize()
    @render state

  resize: ->
    canvas.style.width = "#{innerWidth}px"
    canvas.style.height = "#{innerHeight}px"
    console.log 'resize'
    @renderFrame()

  addSpaces: ->
    for x in [-2..2]
      for y in [-2..2]
        space = new Space
        @spaces.push space
        space.setup
          img:
            x: imgs.fg.width
            y: imgs.fg.height
          x: x
          y: y
          level: 1

  setState: ->
    @inSteps = no
    @duration = 400

  render: (state) ->
    @renderFrame()
    @oldState = state

  animate: (state, callback) ->
    @inSteps = yes
    @renderSteps @oldState
    self = @
    setTimeout ->
      self.inSteps = no
      callback()
      console.log 'animate end'
    , @duration

  renderFrame: (state) ->

  renderSteps: (newState) ->
    do loopRender = =>
      return unless @inSteps
      @renderSpaces()
      requestAnimationFrame(loopRender)

  locate: (location) ->
    console.log 'locate: todo'
    x: 0, y: 0

  renderSpaces: ->