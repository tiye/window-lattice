
exports.at = (s, e, r) ->
  return s unless e?
  x: (e.x * r) + (s.x * (1 - r))
  y: (e.y * r) + (s.y * (1 - r))
  w: (e.w * r) + (s.w * (1 - r))
  h: (e.h * r) + (s.h * (1 - r))