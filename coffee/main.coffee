
{loadImage} = require './image'
{lattice} = require './control'
{keyMap} = require './keys'

loadImage (fg, bg) ->
  lattice.init()

document.body.addEventListener 'keydown', (event) ->
  event.preventDefault()
  switch event.keyCode
    when keyMap.left then lattice.left()
    when keyMap.right then lattice.right()
    when keyMap.up then lattice.up()
    when keyMap.down then lattice.down()
    when keyMap.esc then lattice.zoomOut()
    when keyMap.enter then lattice.zoomIn()

canvas = document.querySelector('canvas')
canvas.addEventListener 'click', (event) ->
  lattice.click x: event.offsetX, y: event.offsetY

window.addEventListener 'resize', ->
  lattice.resize()