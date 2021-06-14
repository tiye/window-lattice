
import { at } from "./tween";

import { putSpace, clipSpace } from "./algorithm";

export class Space {
  constructor(config) {
    this.img = config.img;
    this.x = config.x;
    this.y = config.y;
    this.makeClip();
  }

  makeClip() {
    var position, windou;
    position = {
      x: this.x,
      y: this.y,
    };
    windou = {
      w: innerWidth,
      h: innerHeight,
    };
    return (this.clip = clipSpace(this.img, position, windou));
  }

  config(state) {
    this.state = state;
    return this.calculate();
  }

  calculate() {
    var position, windou;
    this.oldDetail = this.detail;
    windou = {
      w: innerWidth,
      h: innerHeight,
    };
    position = {
      x: this.x,
      y: this.y,
    };
    return (this.detail = {
      fg: putSpace(position, this.state, windou),
      img: this.clip,
    });
  }

  getDetailAt(ratio) {
    return {
      fg: at(this.oldDetail.fg, this.detail.fg, ratio),
      img: this.clip,
    };
  }

  getDetail() {
    return this.detail;
  }

  isActive() {
    return this.state.x === this.x && this.state.y === this.y;
  }

  contains(point) {
    var fg, inX, inY, ref, ref1;
    fg = this.detail.fg;
    inX = fg.x < (ref = point.x) && ref < fg.x + fg.w;
    inY = fg.y < (ref1 = point.y) && ref1 < fg.y + fg.h;
    return inX && inY;
  }
}
