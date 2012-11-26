define(function(require, exports){
  var ref$, drawWindow, resizeWindow, drawConsole;
  ref$ = require("./draw-window"), drawWindow = ref$.drawWindow, resizeWindow = ref$.resizeWindow;
  drawConsole = require("./draw-console").drawConsole;
  drawWindow();
  drawConsole();
  window.onresize = resizeWindow;
  window.atView = false;
  window.atOverview = false;
  window.atConsole = false;
});