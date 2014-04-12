
project = 'repo/window-lattice'
station = undefined
interval = interval: 300
 
require 'shelljs/make'
fs = require 'fs'
browserify = require 'browserify'
{renderer} = require 'cirru-html'
 
reload = -> station?.reload project
 
target.folder = ->
  mkdir '-p', 'cirru', 'coffee', 'js', 'build', 'css'
  exec 'touch cirru/main.coffee css/style.css README.md'
 
target.cirru = ->
  file = 'cirru/index.cirru'
  render = renderer (cat file), '@filename': file
  html = render()
  fs.writeFile 'index.html', html, 'utf8', (err) ->
    console.log 'done: cirru'
    do reload
 
targetBrowserify = ->
  b = browserify ['./js/main']
  build = fs.createWriteStream 'build/build.js', 'utf8'
  bundle = b.bundle(debug: yes)
  bundle.pipe build
  bundle.on 'end', ->
    console.log 'done: browserify'
    do reload
 
target.js = ->
  exec 'coffee -o js/ -bc coffee/'
 
target.coffee = (name, callback) ->
  exec "coffee -o js/ -bc coffee/#{name}", ->
    console.log "done: coffee, compiled coffee/#{name}"
    do callback
 
target.compile = ->
  target.cirru()
  targetBrowserify()
 
target.watch = ->
  fs.watch 'cirru/', interval, target.cirru
  fs.watch 'coffee/', interval, (type, name) ->
    if type is 'change'
      target.coffee name, ->
        do targetBrowserify
 
  station = require 'devtools-reloader-station'
  station.start()
  console.log 'start watching'