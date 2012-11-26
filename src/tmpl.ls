
define (require, exports) ->

  show = console.log

  exports.tmpl = ->
    isArr = Array.isArray
    isObj = ->
      rule1 = typeof it \object
      rule2 = isArr it
      rule1 and (not rule2)
    isStr = -> typeof it is \string

    show = ->


    parse = ->
      # show \parse, "....#it......"
      res = it.match(/(^\S+)(\s.*)?$/)[0 to 2]
      head = res.1
      attr = res.2 or ''

      name = head.match /^[\w\d-]+/
      if name? then name = name.0 else name = \div

      id = head.match /\/[\w\d-]+/
      if id? then id = id.0[1 to].join('') else id = ''

      clas = head.match /\.[\w\d-]+/g
      unless clas? then clas = []
      clas = clas.map -> it[1 to].join ''

      [name, id, clas.join(' '), attr]

    wrap = (them, child) ->
      [name, id, clas, attr] = them
      # show \\nchild, typeof child, child.length
      unless isStr child then child = generate child
      clas-attr = if clas.length > 0 then "class='#clas'" else ''
      id-attr = if id.length > 0 then "id='#id'" else ''
      "<#name #clas-attr #id-attr #attr>#child</#name>"

    generate = ->
      show \generate, it
      if isArr it then it.map generate .join ''
      else if typeof it is \object
        html = ''
        for key, value of it
          show \\npair, key, value
          html += wrap (parse key), value
        show \\nhtml, html
        html
      else if isStr it then wrap (parse it), ''

    generate it
  return