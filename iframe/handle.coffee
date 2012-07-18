
$ ->
  n = 6
  s = 0
  mini = no
  snap = {}
  $.fx.speeds._default = 400
  read_size = ->
    screen_w = $(window).width()
    screen_h = $(window).height()
    json =
      uw: screen_w
      uh: screen_h
      ew: screen_w * 0.9
      eh: screen_h * 0.9
      sw: screen_w * 0.01
      sh: screen_h * 0.01
  $('#box').append '<table/>'
  $('table').append '<tr/>' for i in [1..n]
  $('tr').append '<td/>' for i in [1..n]
  $('td').append '<iframe/>'
  place =
    x: 0
    y: 0

  rate = undefined
  put_size = ->
    s = read_size()
    json =
      'margin-left': s.sw * 4
      'margin-right': s.sw * 4
      'margin-top': s.sh * 4
      'margin-bottom': s.sh * 4
    $('#box').animate json, 400
    json =
      width: s.ew
      height: s.eh
      'margin-left': s.sw
      'margin-right': s.sw
      'margin-top': s.sh
      'margin-bottom': s.sh - 4
    $('iframe').css json, 400
    json =
      'margin-left': place.x * (s.ew - 1 + 2 * s.sw) * (-1)
      'margin-top': place.y * (s.eh - 1 + 2 * s.sh) * (-1)
    $('body').animate json, 400
    rate = s.uw / (2 * s.sw + n * (2 * s.sw + s.ew))

  $(window).resize put_size
  put_size()
  $(document).keydown (e) ->
    console.log e.keyCode
    if e.ctrlKey and (not mini)
      switch e.keyCode
        when 37 then if place.x > 0 then place.x -= 1
        when 38 then if place.y > 0 then place.y -= 1
        when 39 then if place.x < n - 1 then place.x += 1
        when 40 then if place.y < n - 1 then place.y += 1
        # when 27
        else
          console.log  e.keyCode
          return yes
      put_size()
      return false
    # else if e.keyCode is 27
    #   unless mini
    #     $('#box').transition scale: rate
    #     snap =
    #       'left': $('body').css 'margin-left'
    #       'top': $('body').css 'margin-top'
    #     json =
    #       'margin-left': (-1) * (s.sw + n * (s.sw + s.ew / 2) - s.uw / 2)
    #       'margin-top': (-1) * (s.sh + n * (s.sh + s.eh / 2) - s.uh / 2)
    #     $('body').animate json, 400
    #     mini = yes
    #   else
    #     mini = no
    #     $('#box').transition scale: 1
    #     json =
    #       'margin-left': snap.left
    #       'margin-top': snap.top
    #     $('body').animate json, 400