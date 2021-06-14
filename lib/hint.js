
import { at } from "./tween";

import { putHint } from "./algorithm";

export let hintLayer = {
  init: function (config) {
    return (this.img = config.img);
  },
  config: function (state) {
    this.state = state;
    return this.calculate();
  },
  calculate: function () {
    var windou;
    this.oldDetail = this.detail;
    windou = {
      w: innerWidth,
      h: innerHeight,
    };
    return (this.detail = {
      hint: putHint(this.state, windou),
    });
  },
  getDetailAt: function (ratio) {
    return {
      hint: at(this.oldDetail.hint, this.detail.hint, ratio),
    };
  },
  getDetail: function () {
    return this.detail;
  },
};
