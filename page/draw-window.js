var replace$ = ''.replace;
window.world = {};
window.current = "0_0";
define(function(require, exports){
  var $, tmpl, log, w, h, overviewRatio, viewRatio, createDekstop, desktopN, getLeft, getTop, moveTo, moveLeft, moveRight, moveUp, moveDown, toggleView, toggleOverview;
  $ = require("jquery");
  tmpl = require("./tmpl").tmpl;
  log = require("./tool").log;
  w = window.innerWidth;
  h = window.innerHeight;
  overviewRatio = 1;
  viewRatio = 1;
  createDekstop = function(place, position){
    var x, y, name, desktop, ref$;
    if (!window.world[place]) {
      x = position.x, y = position.y;
      name = x + "_" + y;
      desktop = $(tmpl((ref$ = {}, ref$[".desk/" + name] = {
        ".name": name
      }, ref$)));
      $('#view').append(desktop);
      window.world[place] = {
        p: position,
        desktop: desktop
      };
      return $("#" + name).click(function(){
        return moveTo((-x) + "_" + (-y));
      });
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
        place = x + "_" + y;
        position = {
          x: x,
          y: y
        };
        return createDekstop(place, position);
      });
    });
  };
  getLeft = function(elem){
    var left;
    left = replace$.call(elem.css('left'), "px", '');
    return Number(left) || 0;
  };
  getTop = function(elem){
    var top;
    top = replace$.call(elem.css('top'), "px", '');
    return Number(top) || 0;
  };
  window.moveTo = moveTo = function(name){
    var ref$, x, y;
    log('name', name);
    if (window.world[name] != null) {
      ref$ = window.world[name].p, x = ref$.x, y = ref$.y;
      $('#view').css('left', x * w * viewRatio * 1.02);
      $('#view').css('top', y * h * viewRatio * 1.02);
      return window.current = name;
    }
  };
  window.moveLeft = moveLeft = function(){
    var ref$, x, y;
    ref$ = window.world[window.current].p, x = ref$.x, y = ref$.y;
    return moveTo((x + 1) + "_" + y);
  };
  window.moveRight = moveRight = function(){
    var ref$, x, y;
    ref$ = window.world[window.current].p, x = ref$.x, y = ref$.y;
    return moveTo((x - 1) + "_" + y);
  };
  window.moveUp = moveUp = function(){
    var ref$, x, y;
    ref$ = window.world[window.current].p, x = ref$.x, y = ref$.y;
    return moveTo(x + "_" + (y - 1));
  };
  window.moveDown = moveDown = function(){
    var ref$, x, y;
    ref$ = window.world[window.current].p, x = ref$.x, y = ref$.y;
    return moveTo(x + "_" + (y + 1));
  };
  window.toggleView = toggleView = function(){
    if (!window.atView) {
      $('#view').css('-webkit-transform', "scale(0.92)");
      viewRatio = 0.92;
      moveTo(window.current);
    } else {
      $('#view').css('-webkit-transform', "scale(1)");
      viewRatio = 1;
      moveTo(window.current);
    }
    return window.atView = !window.atView;
  };
  window.toggleOverview = toggleOverview = function(){
    if (!window.atOverview) {
      $('#overview').css('-webkit-transform', "scale(" + overviewRatio + ")");
    } else {
      $('#overview').css('-webkit-transform', "scale(1)");
    }
    return window.atOverview = !window.atOverview;
  };
  exports.drawWindow = function(size){
    (function(){
      var i$, to$, results$ = [];
      for (i$ = 0, to$ = size; i$ <= to$; ++i$) {
        results$.push(i$);
      }
      return results$;
    }()).forEach(desktopN);
    exports.resizeWindow();
    return $("body").keydown(function(e){
      if (e.ctrlKey && !e.altKey) {
        if (!window.atConsole) {
          if (e.keyCode === 81) {
            return toggleView();
          } else if (e.keyCode === 77) {
            return toggleOverview();
          } else if (e.keyCode === 37) {
            return moveLeft();
          } else if (e.keyCode === 39) {
            return moveRight();
          } else if (e.keyCode === 40) {
            return moveUp();
          } else if (e.keyCode === 38) {
            return moveDown();
          }
        }
      }
    });
  };
  window.resizeDesktop = function(size){
    $('#view').html("");
    window.world = {};
    (function(){
      var i$, to$, results$ = [];
      for (i$ = 0, to$ = size; i$ <= to$; ++i$) {
        results$.push(i$);
      }
      return results$;
    }()).forEach(desktopN);
    return exports.resizeWindow();
  };
  exports.resizeWindow = function(){
    var desks, left, top, countDesktop, key, ref$, obj, p, desktop, size;
    w = window.innerWidth;
    h = window.innerHeight;
    desks = $(".desk");
    desks.css({
      width: w + "px"
    });
    desks.css({
      height: h + "px"
    });
    left = getLeft($('#view')) + w / 2 * 1.02;
    top = getTop($('#view')) + h / 2 * 1.02;
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