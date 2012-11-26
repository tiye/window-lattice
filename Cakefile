
{print} = require "util"
{spawn} = require "child_process"

echo = (child, callback) ->
  child.stderr.on "data", (data) ->
    process.stderr.write data.toString()
  child.stdout.on "data", (data) ->
    print data.toString()
  child.on "exit", (code) ->
    callback?() if code is 0

make = (str) -> str.split " "

queue = [
  "jade -O page/ -wP src/index.jade"
  "stylus -o page/ -w src/page.styl"
  "livescript -o page/ -wbc src/handle.ls"
  "livescript -o page/ -wbc src/tool.ls"
  "livescript -o page/ -wbc src/tmpl.ls"
  "livescript -o page/ -wbc src/draw-window.ls"
  "livescript -o page/ -wbc src/draw-console.ls"
  "doodle page/"
]

split = (str) -> str.split " "

task "dev", "watch and convert files", (callback) ->
  queue.map(split).forEach (array) ->
    echo (spawn array[0], array[1..]), callback