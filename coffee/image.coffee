
bg = new Image
fg = new Image

exports.loadImage = (callback) ->
  # bg.src = 'http://jiyinyiyong.u.qiniudn.com/wl-park.jpg'
  # fg.src = 'http://jiyinyiyong.u.qiniudn.com/wl-tea.jpg'
  bg.src = 'jpg/leaves.jpg'
  fg.src = 'jpg/tea.jpg'
  
  count = 0
  done = ->
    count += 1
    if count is 2
      callback fg, bg
    
  bg.onload = done
  fg.onload = done

exports.imgs = {fg, bg}