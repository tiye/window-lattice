

let canvas = document.querySelector("#canvas");

let context = canvas.getContext("2d");

import { Space } from "./spaces";

import { bg } from "./bg";

import { imgs } from "./image";

import { hintLayer } from "./hint";

let hintStyle = "#44f";

let hintOpacity = 0.2;

let imgOpacity = 0.5;

let wallOpcity = 1;

export let paper = {
  init: function (state) {
    this.setState();
    this.addSpaces(state);
    this.configSpaces(state);
    return this.resize(state);
  },
  resize: function (state) {
    this.reClipSpaces();
    this.configSpaces(state);
    canvas.setAttribute("width", innerWidth);
    canvas.setAttribute("height", innerHeight);
    return this.renderFrame(state);
  },
  addSpaces: function (state) {
    var i, j, space, x, y;
    this.spaces = [];
    for (x = i = -2; i <= 2; x = ++i) {
      for (y = j = -2; j <= 2; y = ++j) {
        space = new Space({
          x: x,
          y: y,
          img: {
            w: imgs.fg.width,
            h: imgs.fg.height,
          },
        });
        this.spaces.push(space);
      }
    }
    return bg.init({
      img: {
        w: imgs.bg.width,
        h: imgs.bg.height,
      },
    });
  },
  configSpaces: function (state) {
    var i, len, ref, space;
    ref = this.spaces;
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      space.config(state);
    }
    bg.config(state);
    return hintLayer.config(state);
  },
  reClipSpaces: function () {
    var i, len, ref, results, space;
    ref = this.spaces;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      results.push(space.makeClip());
    }
    return results;
  },
  setState: function () {
    this.inSteps = false;
    return (this.duration = 400);
  },
  render: function (state) {
    this.configSpaces(state);
    return this.renderFrame();
  },
  animate: function (state, callback) {
    var self;
    this.inSteps = true;
    this.configSpaces(state);
    this.renderSteps(state);
    self = this;
    return setTimeout(function () {
      self.inSteps = false;
      callback();
      self.renderFrame();
      return console.log("animate end");
    }, this.duration);
  },
  renderFrame: function () {
    this.renderWallpaper();
    this.renderHint();
    return this.renderSpaces();
  },
  renderSteps: function (newState) {
    var loopRender, startTime;
    startTime = new Date().valueOf();
    return (loopRender = () => {
      var now, ratio;
      if (!this.inSteps) {
        return;
      }
      now = new Date().valueOf();
      ratio = (now - startTime) / this.duration;
      this.renderWallpaperAt(ratio);
      this.renderSpacesAt(ratio);
      this.renderHintAt(ratio);
      return requestAnimationFrame(loopRender);
    })();
  },
  locate: function (point) {
    var i, len, ref, ret, space;
    console.log(point);
    ref = this.spaces;
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      if (space.contains(point)) {
        ret = {
          x: space.x,
          y: space.y,
        };
        return ret;
      }
    }
  },
  renderSpaces: function () {
    var d, i, len, ref, results, space;
    ref = this.spaces;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      d = space.getDetail();
      context.globalAlpha = imgOpacity;
      results.push(
        context.drawImage(
          imgs.fg,
          d.img.x,
          d.img.y,
          d.img.w,
          d.img.h,
          d.fg.x,
          d.fg.y,
          d.fg.w,
          d.fg.h
        )
      );
    }
    return results;
  },
  renderWallpaper: function () {
    var d;
    d = bg.getDetail();
    context.clearRect(0, 0, innerWidth, innerHeight);
    context.globalAlpha = wallOpcity;
    return context.drawImage(
      imgs.bg,
      d.img.x,
      d.img.y,
      d.img.w,
      d.img.h,
      0,
      0,
      innerWidth,
      innerHeight
    );
  },
  renderHint: function () {
    var hint, i, len, ref, results, space;
    ref = this.spaces;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      if (space.isActive()) {
        ({ hint } = hintLayer.getDetail());
        context.fillStyle = hintStyle;
        context.globalAlpha = hintOpacity;
        results.push(context.fillRect(hint.x, hint.y, hint.w, hint.h));
      } else {
        results.push(void 0);
      }
    }
    return results;
  },
  renderSpacesAt: function (ratio) {
    var d, i, len, ref, results, space;
    ref = this.spaces;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      d = space.getDetailAt(ratio);
      context.globalAlpha = imgOpacity;
      results.push(
        context.drawImage(
          imgs.fg,
          d.img.x,
          d.img.y,
          d.img.w,
          d.img.h,
          d.fg.x,
          d.fg.y,
          d.fg.w,
          d.fg.h
        )
      );
    }
    return results;
  },
  renderWallpaperAt: function (ratio) {
    var d;
    d = bg.getDetailAt(ratio);
    context.clearRect(0, 0, innerWidth, innerHeight);
    context.globalAlpha = wallOpcity;
    return context.drawImage(
      imgs.bg,
      d.img.x,
      d.img.y,
      d.img.w,
      d.img.h,
      0,
      0,
      innerWidth,
      innerHeight
    );
  },
  renderHintAt: function (ratio) {
    var hint, i, len, ref, results, space;
    ref = this.spaces;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      space = ref[i];
      if (space.isActive()) {
        ({ hint } = hintLayer.getDetailAt(ratio));
        context.fillStyle = hintStyle;
        context.globalAlpha = hintOpacity;
        results.push(context.fillRect(hint.x, hint.y, hint.w, hint.h));
      } else {
        results.push(void 0);
      }
    }
    return results;
  },
};
