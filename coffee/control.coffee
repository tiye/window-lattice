
{paper} = require './paint'

exports.lattice =
  init: ->
    @setupState()
    paper.init @state
    console.log 'render'

  setupState: ->
    @state =
      x: 0
      y: 0
      level: 1
    @inTransition = no

  left: ->
    return if @inTransition
    if @state.x > -2
      @state.x -= 1
      @animate()

  right: ->
    return if @inTransition
    if @state.x < 2
      @state.x += 1
      @animate()

  up: ->
    return if @inTransition
    if @state.y > -2
      @state.y -= 1
      @animate()

  down: ->
    return if @inTransition
    if @state.y < 2
      @state.y +=1
      @animate()

  zoomIn: ->
    return if @inTransition
    if @state.level > 1
      @state.level -= 2
      @animate()
    else if @state.level is 1
      @state.level = 0
      @animate()

  zoomOut: ->
    return if @inTransition
    if @state.level is 0
      @state.level = 1
      @animate()
    else if @state.level < 5
      @state.level += 2
      @animate()

  animate: ->
    console.clear()
    console.log 'animate state:',
      x: @state.x
      y: @state.y
      level: @state.level
    @inTransition = yes
    paper.animate @state, =>
      @inTransition = no

  click: (position) ->
    location = paper.locate position
    unless location?
      console.log 'found no space'
      return
    changed = no
    if @state.x isnt location.x
      @state.x = location.x
      changed = yes
    if @state.y isnt location.y
      @state.y = location.y
      changed = yes

    if changed
      @animate()
    else if @state.level isnt 1
      @state.level = 1
      @animate()

  resize: ->
    paper.resize @state