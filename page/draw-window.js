window.world = {};
define(function(require, exports){
  var $, tmpl, log, w, h, overviewRatio, createDekstop, desktopN;
  $ = require("jquery");
  tmpl = require("./tmpl").tmpl;
  log = require("./tool").log;
  w = window.innerWidth;
  h = window.innerHeight;
  overviewRatio = 0;
  createDekstop = function(place, position){
    var desktop;
    if (!window.world[place]) {
      desktop = $(tmpl({
        ".desk": "desk"
      }));
      $('#view').append(desktop);
      return window.world[place] = {
        p: position,
        desktop: desktop
      };
    }
  };
  desktopN = function(n){
    return (function(){
      var i$, to$, results$ = [];
      for (i$ = -n, to$ = n; i$ <= to$; ++i$) {
        results$.push(i$);
      }
      return results$;
    }()).forEach(function(y){
      return (function(){
        var i$, to$, results$ = [];
        for (i$ = -n, to$ = n; i$ <= to$; ++i$) {
          results$.push(i$);
        }
        return results$;
      }()).forEach(function(x){
        var place, position;
        place = y + "&" + x;
        position = {
          x: x,
          y: y
        };
        return createDekstop(place, position);
      });
    });
  };
  exports.drawWindow = function(){
    var i$, ref$, len$, n;
    for (i$ = 0, len$ = (ref$ = [0, 1, 2, 3]).length; i$ < len$; ++i$) {
      n = ref$[i$];
      desktopN(n);
    }
    exports.resizeWindow();
    return $("body").keypress(function(e){
      log(e.keyCode);
      if (e.ctrlKey && !e.altKey) {
        if (window.atConsole != null) {
          if (e.keyCode === 17) {
            if (!window.atView) {
              $('#view').css('-webkit-transform', "scale(0.92)");
            } else {
              $('#view').css('-webkit-transform', "scale(1)");
            }
            return window.atView = !window.atView;
          } else if (e.keyCode === 13) {
            if (!window.atOverview) {
              $('#overview').css('-webkit-transform', "scale(" + overviewRatio + ")");
            } else {
              $('#overview').css('-webkit-transform', "scale(1)");
            }
            return window.atOverview = !window.atOverview;
          }
        }
      }
    });
  };
  exports.resizeWindow = function(){
    var desks, countDesktop, key, ref$, obj, p, desktop, size;
    w = window.innerWidth;
    h = window.innerHeight;
    desks = $(".desk");
    desks.css({
      width: w + "px"
    });
    desks.css({
      height: h + "px"
    });
    $('#view').css('-webkit-transform-origin', w / 2 + "px " + h / 2 + "px");
    $('#overview').css('-webkit-transform-origin', w / 2 + "px " + h / 2 + "px");
    countDesktop = 0;
    for (key in ref$ = world) {
      obj = ref$[key];
      p = obj.p, desktop = obj.desktop;
      desktop.css('left', p.x * w * 1.02 + "px");
      desktop.css('top', p.y * h * 1.02 + "px");
      countDesktop += 1;
    }
    size = Math.sqrt(countDesktop);
    return overviewRatio = 1 / (size - 2) / 1.02;
  };
});