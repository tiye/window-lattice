
import { paper } from "./paint";

export let lattice = {
  init: function () {
    this.setupState();
    paper.init(this.state);
    return console.log("render");
  },
  setupState: function () {
    this.state = {
      x: 0,
      y: 0,
      level: 1,
    };
    return (this.inTransition = false);
  },
  left: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.x > -2) {
      this.state.x -= 1;
      return this.animate();
    }
  },
  right: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.x < 2) {
      this.state.x += 1;
      return this.animate();
    }
  },
  up: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.y > -2) {
      this.state.y -= 1;
      return this.animate();
    }
  },
  down: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.y < 2) {
      this.state.y += 1;
      return this.animate();
    }
  },
  zoomIn: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.level > 1) {
      this.state.level -= 2;
      return this.animate();
    } else if (this.state.level === 1) {
      this.state.level = 0;
      return this.animate();
    }
  },
  zoomOut: function () {
    if (this.inTransition) {
      return;
    }
    if (this.state.level === 0) {
      this.state.level = 1;
      return this.animate();
    } else if (this.state.level < 5) {
      this.state.level += 2;
      return this.animate();
    }
  },
  animate: function () {
    console.clear();
    console.log("animate state:", {
      x: this.state.x,
      y: this.state.y,
      level: this.state.level,
    });
    this.inTransition = true;
    return paper.animate(this.state, () => {
      return (this.inTransition = false);
    });
  },
  click: function (position) {
    var changed, location;
    location = paper.locate(position);
    if (location == null) {
      console.log("found no space");
      return;
    }
    changed = false;
    if (this.state.x !== location.x) {
      this.state.x = location.x;
      changed = true;
    }
    if (this.state.y !== location.y) {
      this.state.y = location.y;
      changed = true;
    }
    if (changed) {
      return this.animate();
    } else if (this.state.level !== 1) {
      this.state.level = 1;
      return this.animate();
    }
  },
  resize: function () {
    return paper.resize(this.state);
  },
};
