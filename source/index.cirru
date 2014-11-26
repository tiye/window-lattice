doctype

html
  head
    title "Window Lattice"
    meta (:charset utf-8)
    link (:rel icon) (:type image/x-icon)
      :href "http://jiyinyiyong.u.qiniudn.com/window-lattice.png"
    script(:src build/vendor.min.js)
    @if (@ dev)
      @block
        link (:rel stylesheet) (:href source/main.css)
        script (:defer) (:src build/main.js)
      @block
        link (:rel stylesheet) (:href build/main.min.css)
        script (:defer) (:src build/main.min.js)
  body#app
    canvas#canvas