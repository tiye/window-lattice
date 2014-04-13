
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

  # return clip
  c =
    x: (clip.x + clip.w) / 2
    y: (clip.y + clip.h) / 2

  shift =
    x: position.x
    y: position.y

  if position.level is 5
    shift.x = 0
    shift.y = 0
  else if position.level is 3
    if shift.x > 1 then shift.x = 1
    else if shift.x < - 1 then shift.x = -1
    if shift.y > 1 then shift.y = 1
    else if shift.y < - 1 then shift.y = -1

  console.log 'shift:', shift, position

  if position.level is 5
    ratio = 1
  else if position.level is 3
    ratio = 0.4
  else
    ratio = 0.2

  u =
    w: clip.w * ratio
    h: clip.h * ratio

  x: c.x + (u.w * shift.x * 0.6) - (u.w / 2)
  y: c.y + (u.h * shift.y * 0.6) - (u.h / 2)
  w: u.w
  h: u.h
    
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
  u =
    w: windou.w / ((2 * paddingRatio) + state.level)
    h: windou.h / ((2 * paddingRatio) + state.level)
  c =
    x: windou.w / 2
    y: windou.h / 2
  if state.level is 0
    x: windou.w * (p.x - state.x)
    y: windou.h * (p.y - state.y)
    w: windou.w
    h: windou.h
  else if state.level is 1
    x: c.x \
      - u.w * fillRatio / 2 \
      + u.w * (p.x - state.x)
    y: c.y \
      - u.h * fillRatio / 2 \
      + u.h * (p.y - state.y)
    w: u.w * fillRatio
    h: u.h * fillRatio
  else if state.level is 3
    shift =
      x: state.x
      y: state.y
    if shift.x > 1 then shift.x = 1
    if shift.x < -1 then shift.x = -1
    if shift.y > 1 then shift.y = 1
    if shift.y < -1 then shift.y = -1
    x: c.x \
      - u.w * fillRatio / 2 \
      + u.w * (p.x - shift.x)
    y: c.y \
      - u.h * fillRatio / 2 \
      + u.h * (p.y - shift.y)
    w: u.w * fillRatio
    h: u.h * fillRatio
  else if state.level is 5
    x: c.x \
      - u.w * fillRatio / 2 \
      + u.w * p.x
    y: c.y \
      - u.h * fillRatio / 2 \
      + u.h * p.y
    w: u.w * fillRatio
    h: u.h * fillRatio

exports.putHint = (state, windou) ->
  u =
    w: windou.w / ((2 * paddingRatio) + state.level)
    h: windou.h / ((2 * paddingRatio) + state.level)
  c =
    x: windou.w / 2
    y: windou.h / 2
  if state.level is 0
    x: 0
    y: 0
    w: windou.w
    h: windou.h
  else if state.level is 1
    x: c.x - (u.w / 2)
    y: c.y - (u.h / 2)
    w: u.w
    h: u.h
  else if state.level is 3
    ret = 
      w: u.w
      h: u.h

    if -1 <= state.x <= 1
      ret.x = c.x - (u.w / 2)
    else if state.x < -1
      ret.x = c.x - (u.w / 2 ) - u.w
    else if state.x > 1
      ret.x = c.x - (u.w / 2 ) + u.w
    if -1 <= state.y <= 1
      ret.y = c.y - (u.h / 2)
    else if state.y < -1
      ret.y = c.y - (u.h / 2 ) - u.h
    else if state.y > 1
      ret.y = c.y - (u.h / 2 ) + u.h
    ret
  else if state.level is 5
    x: c.x - (u.w / 2 ) + (u.w * state.x)
    y: c.y - (u.h / 2 ) + (u.h * state.y)
    w: u.w
    h: u.h