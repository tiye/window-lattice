
bg_link = 'leafs.jpg'
fg_link = 'sun.jpg'

screen =
	x: 800
	y: 450
center =
	x: screen.x/2
	y: screen.y/2
p =
	x: 0
	y: 0
at_p =
	x: 0
	y: 0
new_p =
	x: 0
	y: 0
tile =
	x: screen.x - 16*8
	y: screen.y - 9*8
wall =
	x: 800*2.6
	y: 450*2.6

space = 18

scale = 1
at_scale = 1
new_scale = 1

main = ->
	canvas = document.getElementById 'canvas'
	ctx = canvas.getContext '2d'
	fg = new Image()
	fg.src = fg_link
	fg.opacity = 0.6
	fg.onload = ->
		bg = new Image()
		bg.src = bg_link
		bg.onload = ->
			draw ctx, bg, fg, p, scale
			document.onkeydown = (e) ->
				if e.keyCode in [37,38,39,40,13]
					switch e.keyCode
						when 37
							if new_p.x > -100 then new_p.x -= (tile.x + space)
						when 38
							if new_p.y > -100 then new_p.y -= (tile.y + space)
						when 39
							if new_p.x < 100 then new_p.x += (tile.x + space)
						when 40
							if new_p.y < 100 then new_p.y += (tile.y + space)
						else
							new_scale = 1 - scale
					start = newTime()
					console.log start
					step = (timestemp) ->
						process = timestemp - start
						at_p.x = (new_p.x - p.x)*process/1000 + p.x
						at_p.y = (new_p.y - p.y)*process/1000 + p.y
						at_scale = scale + (new_scale - scale)*process/1000
						draw ctx, bg, fg, at_p, at_scale
						if process < 1000
							newFrame step
						else
							p.x = new_p.x
							p.y = new_p.y
							scale = new_scale
							console.log p
					console.log p, new_p, scale, new_scale
					if p.x != new_p.x or p.y != new_p.y or scale != new_scale
						newFrame step
						console.log 'call newFrame'

newFrame = window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame
newTime = ->
	window.mozAnimationStartTime || Date.now()

draw = (ctx, bg, fg, p, scale) ->
	p.x *= scale
	p.y *= scale
	k = 2.9
	rate = 1/k + (1-1/k)*scale
	ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height
	bgrate = 1 + (scale - 1)/k
	bgx = center.x + (- p.x/1.8 - wall.x/2)*bgrate
	bgy = center.y + (- p.y/1.8 - wall.y/2)*bgrate
	ctx.drawImage bg, 0, 0, bg.width, bg.width/16*9, bgx, bgy, wall.x*bgrate, wall.y*bgrate
	ctx.save()
	ctx.globalAlpha = 0.96
	# ctx.shadowBlur = 10
	# ctx.shadowColor = 'black'
	for xn in [-2,-1,0,1,2]
		for yn in [-2,-1,0,1,2]
			x = center.x + (- p.x - tile.x/2 + xn*(tile.x + space))*rate
			y = center.y + (- p.y - tile.y/2 + yn*(tile.y + space))*rate
			ctx.drawImage fg, fg.width*(xn+2)/5, fg.width/16*9*(yn+2)/5, fg.width/5, fg.width/16*9/5, x, y, tile.x*rate, tile.y*rate
	ctx.globalAlpha = 1
	# ctx.shadowBlur = 0

window.onload = main
