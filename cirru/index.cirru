
doctype
html
  head
    title (= "Window Lattice")
    meta (:charset utf-8)
    link (:rel icon) (:type image/x-icon)
      :href "http://jiyinyiyong.u.qiniudn.com/window-lattice.png"
    link (:rel stylesheet) (:href css/page.css)
    script (:defer) (:src build/build.js)
  body#app
    canvas#canvas