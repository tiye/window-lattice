
let fillRatio = 0.95;

let paddingRatio = 0.1;

let imgClip = function (img, windou) {
  var clip;
  clip = {
    x: 0,
    y: 0,
    w: 0,
    h: 0,
  };
  windou.ratio = windou.w / windou.h;
  img.ratio = img.w / img.h;
  if (windou.ratio > img.ratio) {
    clip.w = img.w;
    clip.h = img.w / windou.ratio;
    clip.y = (img.h - clip.h) / 2;
  } else {
    clip.h = img.h;
    clip.w = img.h * windou.ratio;
    clip.x = (img.w - clip.w) / 2;
  }
  return clip;
};

export let clipWallpaper = function (img, position, windou) {
  var c, clip, ratio, shift, u;
  clip = imgClip(img, windou);
  // return clip
  c = {
    x: clip.x + clip.w / 2,
    y: clip.y + clip.h / 2,
  };
  shift = {
    x: position.x,
    y: position.y,
  };
  if (position.level === 5) {
    shift.x = 0;
    shift.y = 0;
  } else if (position.level === 3) {
    if (shift.x > 1) {
      shift.x = 1;
    } else if (shift.x < -1) {
      shift.x = -1;
    }
    if (shift.y > 1) {
      shift.y = 1;
    } else if (shift.y < -1) {
      shift.y = -1;
    }
  }
  console.log("shift:", shift, position);
  if (position.level === 5) {
    ratio = 1;
  } else if (position.level === 3) {
    ratio = 1 / 3;
  } else {
    ratio = 0.2;
  }
  u = {
    w: clip.w * ratio,
    h: clip.h * ratio,
  };
  return {
    x: c.x - u.w / 2 + u.w * shift.x * 0.5 * ratio,
    y: c.y - u.h / 2 + u.h * shift.y * 0.5 * ratio,
    w: u.w,
    h: u.h,
  };
};

export let clipSpace = function (img, position, windou) {
  var c, clip, u;
  clip = imgClip(img, windou);
  c = {
    x: clip.x + clip.w / 2,
    y: clip.y + clip.h / 2,
  };
  u = {
    w: clip.w / 5,
    h: clip.h / 5,
  };
  return {
    x: c.x + u.w * (position.x - fillRatio / 2),
    y: c.y + u.h * (position.y - fillRatio / 2),
    w: u.w * fillRatio,
    h: u.h * fillRatio,
  };
};

export let putSpace = function (p, state, windou) {
  var c, shift, u;
  u = {
    w: windou.w / (2 * paddingRatio + state.level),
    h: windou.h / (2 * paddingRatio + state.level),
  };
  c = {
    x: windou.w / 2,
    y: windou.h / 2,
  };
  if (state.level === 0) {
    return {
      x: windou.w * (p.x - state.x),
      y: windou.h * (p.y - state.y),
      w: windou.w,
      h: windou.h,
    };
  } else if (state.level === 1) {
    return {
      x: c.x - (u.w * fillRatio) / 2 + u.w * (p.x - state.x),
      y: c.y - (u.h * fillRatio) / 2 + u.h * (p.y - state.y),
      w: u.w * fillRatio,
      h: u.h * fillRatio,
    };
  } else if (state.level === 3) {
    shift = {
      x: state.x,
      y: state.y,
    };
    if (shift.x > 1) {
      shift.x = 1;
    }
    if (shift.x < -1) {
      shift.x = -1;
    }
    if (shift.y > 1) {
      shift.y = 1;
    }
    if (shift.y < -1) {
      shift.y = -1;
    }
    return {
      x: c.x - (u.w * fillRatio) / 2 + u.w * (p.x - shift.x),
      y: c.y - (u.h * fillRatio) / 2 + u.h * (p.y - shift.y),
      w: u.w * fillRatio,
      h: u.h * fillRatio,
    };
  } else if (state.level === 5) {
    return {
      x: c.x - (u.w * fillRatio) / 2 + u.w * p.x,
      y: c.y - (u.h * fillRatio) / 2 + u.h * p.y,
      w: u.w * fillRatio,
      h: u.h * fillRatio,
    };
  }
};

export let putHint = function (state, windou) {
  var c, ref, ref1, ret, u;
  u = {
    w: windou.w / (2 * paddingRatio + state.level),
    h: windou.h / (2 * paddingRatio + state.level),
  };
  c = {
    x: windou.w / 2,
    y: windou.h / 2,
  };
  if (state.level === 0) {
    return {
      x: 0,
      y: 0,
      w: windou.w,
      h: windou.h,
    };
  } else if (state.level === 1) {
    return {
      x: c.x - u.w / 2,
      y: c.y - u.h / 2,
      w: u.w,
      h: u.h,
    };
  } else if (state.level === 3) {
    ret = {
      w: u.w,
      h: u.h,
    };
    if (-1 <= (ref = state.x) && ref <= 1) {
      ret.x = c.x - u.w / 2;
    } else if (state.x < -1) {
      ret.x = c.x - u.w / 2 - u.w;
    } else if (state.x > 1) {
      ret.x = c.x - u.w / 2 + u.w;
    }
    if (-1 <= (ref1 = state.y) && ref1 <= 1) {
      ret.y = c.y - u.h / 2;
    } else if (state.y < -1) {
      ret.y = c.y - u.h / 2 - u.h;
    } else if (state.y > 1) {
      ret.y = c.y - u.h / 2 + u.h;
    }
    return ret;
  } else if (state.level === 5) {
    return {
      x: c.x - u.w / 2 + u.w * state.x,
      y: c.y - u.h / 2 + u.h * state.y,
      w: u.w,
      h: u.h,
    };
  }
};
