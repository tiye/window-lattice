var at_p, at_scale, bg_link, center, draw, fg_link, main, newFrame, newTime, new_p, new_scale, p, scale, screen, space, tile, wall;

bg_link = 'leafs.jpg';

fg_link = 'sun.jpg';

screen = {
  x: 800,
  y: 450
};

center = {
  x: screen.x / 2,
  y: screen.y / 2
};

p = {
  x: 0,
  y: 0
};

at_p = {
  x: 0,
  y: 0
};

new_p = {
  x: 0,
  y: 0
};

tile = {
  x: screen.x - 16 * 8,
  y: screen.y - 9 * 8
};

wall = {
  x: 800 * 2.6,
  y: 450 * 2.6
};

space = 18;

scale = 1;

at_scale = 1;

new_scale = 1;

main = function() {
  var canvas, ctx, fg;
  canvas = document.getElementById('canvas');
  ctx = canvas.getContext('2d');
  fg = new Image();
  fg.src = fg_link;
  fg.opacity = 0.6;
  return fg.onload = function() {
    var bg;
    bg = new Image();
    bg.src = bg_link;
    return bg.onload = function() {
      draw(ctx, bg, fg, p, scale);
      return document.onkeydown = function(e) {
        var start, step, _ref;
        if ((_ref = e.keyCode) === 37 || _ref === 38 || _ref === 39 || _ref === 40 || _ref === 13) {
          switch (e.keyCode) {
            case 37:
              if (new_p.x > -100) new_p.x -= tile.x + space;
              break;
            case 38:
              if (new_p.y > -100) new_p.y -= tile.y + space;
              break;
            case 39:
              if (new_p.x < 100) new_p.x += tile.x + space;
              break;
            case 40:
              if (new_p.y < 100) new_p.y += tile.y + space;
              break;
            default:
              new_scale = 1 - scale;
          }
          start = newTime();
          console.log(start);
          step = function(timestemp) {
            var process;
            process = timestemp - start;
            at_p.x = (new_p.x - p.x) * process / 1000 + p.x;
            at_p.y = (new_p.y - p.y) * process / 1000 + p.y;
            at_scale = scale + (new_scale - scale) * process / 1000;
            draw(ctx, bg, fg, at_p, at_scale);
            if (process < 1000) {
              return newFrame(step);
            } else {
              p.x = new_p.x;
              p.y = new_p.y;
              scale = new_scale;
              return console.log(p);
            }
          };
          console.log(p, new_p, scale, new_scale);
          if (p.x !== new_p.x || p.y !== new_p.y || scale !== new_scale) {
            newFrame(step);
            return console.log('call newFrame');
          }
        }
      };
    };
  };
};

newFrame = window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame;

newTime = function() {
  return window.mozAnimationStartTime || Date.now();
};

draw = function(ctx, bg, fg, p, scale) {
  var bgrate, bgx, bgy, k, rate, x, xn, y, yn, _i, _j, _len, _len2, _ref, _ref2;
  p.x *= scale;
  p.y *= scale;
  k = 2.9;
  rate = 1 / k + (1 - 1 / k) * scale;
  ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  bgrate = 1 + (scale - 1) / k;
  bgx = center.x + (-p.x / 1.8 - wall.x / 2) * bgrate;
  bgy = center.y + (-p.y / 1.8 - wall.y / 2) * bgrate;
  ctx.drawImage(bg, 0, 0, bg.width, bg.width / 16 * 9, bgx, bgy, wall.x * bgrate, wall.y * bgrate);
  ctx.save();
  ctx.globalAlpha = 0.96;
  _ref = [-2, -1, 0, 1, 2];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    xn = _ref[_i];
    _ref2 = [-2, -1, 0, 1, 2];
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      yn = _ref2[_j];
      x = center.x + (-p.x - tile.x / 2 + xn * (tile.x + space)) * rate;
      y = center.y + (-p.y - tile.y / 2 + yn * (tile.y + space)) * rate;
      ctx.drawImage(fg, fg.width * (xn + 2) / 5, fg.width / 16 * 9 * (yn + 2) / 5, fg.width / 5, fg.width / 16 * 9 / 5, x, y, tile.x * rate, tile.y * rate);
    }
  }
  return ctx.globalAlpha = 1;
};

window.onload = main;
