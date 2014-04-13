
bg = new Image
fg = new Image

exports.loadImage = (callback) ->
  # bg.src = 'http://jiyinyiyong.u.qiniudn.com/wl-park.jpg'
  # fg.src = 'http://jiyinyiyong.u.qiniudn.com/wl-tea.jpg'
  bg.src = 'jpg/marts.svg'
  # bg.src = 'jpg/cloud2.svg'
  # fg.src = 'jpg/tea.jpg'
  fg.src = 'jpg/sky.svg'
  
  count = 0
  done = ->
    count += 1
    if count is 2
      callback fg, bg
    
  bg.onload = done
  fg.onload = done

exports.imgs = {fg, bg}