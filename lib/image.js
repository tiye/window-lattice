let bg = new Image();

let fg = new Image();

import p1 from "../assets/birds.jpg";
import p2 from "../assets/grass.jpg";

export let loadImage = function (callback) {
  var count, done;
  bg.src = p1;
  fg.src = p2;
  count = 0;
  done = function () {
    count += 1;
    if (count === 2) {
      return callback(fg, bg);
    }
  };
  bg.onload = done;
  return (fg.onload = done);
};

export let imgs = { fg, bg };
