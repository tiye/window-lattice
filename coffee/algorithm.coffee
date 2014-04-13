
fillRatio = 0.9
viewPadding = 20

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

exports.putSpace = (windou, position) ->
  x: 0, y:0, w:0, h:0