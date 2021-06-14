
import { loadImage } from "./image";

import { lattice } from "./control";

import { keyMap } from "./keys";

loadImage(function (fg, bg) {
  return lattice.init();
});

document.body.addEventListener("keydown", function (event) {
  var prevent;
  prevent = true;
  switch (event.keyCode) {
    case keyMap.left:
      lattice.left();
      break;
    case keyMap.right:
      lattice.right();
      break;
    case keyMap.up:
      lattice.up();
      break;
    case keyMap.down:
      lattice.down();
      break;
    case keyMap.esc:
      lattice.zoomOut();
      break;
    case keyMap.enter:
      lattice.zoomIn();
      break;
    default:
      prevent = false;
  }
  if (prevent) {
    return event.preventDefault();
  }
});

let canvas = document.querySelector("canvas");

canvas.addEventListener("click", function (event) {
  return lattice.click({
    x: event.offsetX,
    y: event.offsetY,
  });
});

window.addEventListener("resize", function () {
  return lattice.resize();
});
