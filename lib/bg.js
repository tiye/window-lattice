
import { at } from "./tween";

import { clipWallpaper } from "./algorithm";

export let bg = {
  init: function (config) {
    return (this.img = config.img);
  },
  config: function (position) {
    this.position = position;
    return this.calculate();
  },
  calculate: function () {
    var windou;
    this.oldDetail = this.detail;
    console.log(this.img, this.position);
    windou = {
      w: innerWidth,
      h: innerHeight,
    };
    return (this.detail = {
      img: clipWallpaper(this.img, this.position, windou),
    });
  },
  getDetailAt: function (ratio) {
    return {
      // return @detail
      img: at(this.oldDetail.img, this.detail.img, ratio),
    };
  },
  getDetail: function () {
    return this.detail;
  },
};
