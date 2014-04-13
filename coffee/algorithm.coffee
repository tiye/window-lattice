
fillRatio = 0.95
paddingRatio = 0.1

imgClip = (img, windou) ->
  clip =
    x: 0
    y: 0
    w: 0
    h: 0
  windou.ratio = windou.w / windou.h
  img.ratio = img.w / img.h
  if windou.ratio > img.ratio
    clip.w = img.w
    clip.h = img.w / windou.ratio
    clip.y = (img.h - clip.h) / 2
  else
    clip.h = img.h
    clip.w = img.h * windou.ratio
    clip.x = (img.w - clip.w) / 2
  clip

exports.clipWallpaper = (img, position, windou) ->
  clip = imgClip img, windou

  x: 0, y:0, w:0, h:0

exports.clipSpace = (img, position, windou) ->
  clip = imgClip img, windou  

  c =
    x: (clip.x + clip.w) / 2
    y: (clip.y + clip.h) / 2
  u =
    w: clip.w / 5
    h: clip.h / 5

  x: c.x + (u.w * (position.x - (fillRatio / 2)))
  y: c.y + (u.h * (position.y - (fillRatio / 2)))
  w: u.w * fillRatio
  h: u.h * fillRatio

exports.putSpace = (p, state, windou) ->
  if state.level is 0
    x: windou.w * (p.x - state.x)
    y: windou.h * (p.y - state.y)
    w: windou.w
    h: windou.h
  else
    u =
      w: windou.w / ((2 * paddingRatio) + state.level)
      h: windou.h / ((2 * paddingRatio) + state.level)
    c =
      x: windou.w / 2
      y: windou.h / 2
    
    x: c.x \
      - u.w * fillRatio / 2 \
      + u.w * (p.x - state.x)
    y: c.y \
      - u.h * fillRatio / 2 \
      + u.h * (p.y - state.y)
    w: u.w * fillRatio
    h: u.h * fillRatio

exports.putHint = (state, windou) ->
  if state.level is 0
    x: 0
    y: 0
    w: windou.w
    h: windou.h
  else
    u =
      w: windou.w / ((2 * paddingRatio) + state.level)
      h: windou.h / ((2 * paddingRatio) + state.level)
    c =
      x: windou.w / 2
      y: windou.h / 2
  
    x: c.x \
      - u.w / 2
    y: c.y \
      - u.h / 2
    w: u.w
    h: u.h
