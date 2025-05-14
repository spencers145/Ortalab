#ifdef GL_ES
  precision mediump float;
  precision mediump int;
#endif

extern vec2 anaglyphic;
extern float dissolve;
extern float time;
extern vec4 texture_details;
extern vec2 image_details;
extern bool shadow;
extern vec4 burn_colour_1;
extern vec4 burn_colour_2;
extern float hovering;
extern vec2 mouse_screen_pos;
extern float screen_scale;

// dissolve mask
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv) {
  if (dissolve < 0.001) {
    return vec4(shadow ? vec3(0.0) : tex.xyz,
                shadow ? tex.a * 0.3 : tex.a);
  }
  float adjusted_dissolve = (dissolve * dissolve * (3.0 - 2.0 * dissolve)) * 1.02 - 0.01;
  float t = time * 10.0 + 2003.0;
  vec2 floored_uv = floor(uv * texture_details.ba) / max(texture_details.b, texture_details.a);
  vec2 uv_scaled = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
  vec2 f1 = uv_scaled + 50.0 * vec2(sin(-t / 143.634), cos(-t / 99.4324));
  vec2 f2 = uv_scaled + 50.0 * vec2(cos(t / 53.1532), cos(t / 61.4532));
  vec2 f3 = uv_scaled + 50.0 * vec2(sin(-t / 87.53218), sin(-t / 49.0));
  float field = (1.0 + (
      cos(length(f1) / 19.483) +
      sin(length(f2) / 33.155) * cos(f2.y / 15.73) +
      cos(length(f3) / 27.193) * sin(f3.x / 21.92)
    )) * 0.5;
  vec2 b = vec2(0.2, 0.8);
  float res = (0.5 + 0.5 * cos(adjusted_dissolve / 82.612 + (field - 0.5) * 3.14))
    - (floored_uv.x > b.y ? (floored_uv.x - b.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.y > b.y ? (floored_uv.y - b.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.x < b.x ? (b.x - floored_uv.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
    - (floored_uv.y < b.x ? (b.x - floored_uv.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve;
  if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow &&
      res > adjusted_dissolve &&
      res < adjusted_dissolve + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5))) {
    tex = res < adjusted_dissolve + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5))
      ? burn_colour_1
      : (burn_colour_2.a > 0.01 ? burn_colour_2 : tex);
  }
  return vec4(shadow ? vec3(0.0) : tex.xyz,
              res > adjusted_dissolve ? (shadow ? tex.a * 0.3 : tex.a) : 0.0);
}

// hue conversion
float hue(float s, float t, float h) {
  float hs = mod(h, 1.0) * 6.0;
  if (hs < 1.0) return (t - s) * hs + s;
  if (hs < 3.0) return t;
  if (hs < 4.0) return (t - s) * (4.0 - hs) + s;
  return s;
}

// RGB from HSL
vec4 RGB(vec4 c) {
  if (c.y < 0.0001) return vec4(vec3(c.z), c.a);
  float tVal = (c.z < 0.5 ? c.y * c.z + c.z : -c.y * c.z + (c.y + c.z));
  float sVal = 2.0 * c.z - tVal;
  return vec4(
    hue(sVal, tVal, c.x + 1.0/3.0),
    hue(sVal, tVal, c.x),
    hue(sVal, tVal, c.x - 1.0/3.0),
    c.w
  );
}

// HSL conversion
vec4 HSL(vec4 c) {
  float low = min(c.r, min(c.g, c.b));
  float high = max(c.r, max(c.g, c.b));
  float d = high - low;
  float sumVal = high + low;
  vec4 hsl = vec4(0.0, 0.0, 0.5 * sumVal, c.a);
  if (d == 0.0) return hsl;
  hsl.y = (hsl.z < 0.5) ? d / sumVal : d / (2.0 - sumVal);
  if (high == c.r) hsl.x = (c.g - c.b) / d;
  else if (high == c.g) hsl.x = (c.b - c.r) / d + 2.0;
  else hsl.x = (c.r - c.g) / d + 4.0;
  hsl.x = mod(hsl.x / 6.0, 1.0);
  return hsl;
}

// main effect
vec4 effect(mediump vec4 colour, Image texture, mediump vec2 tc, mediump vec2 sc) {
  vec2 uv = (tc * image_details - texture_details.xy * texture_details.ba) / texture_details.ba;
  vec2 center = uv - vec2(0.5);
  center.x *= texture_details.b / texture_details.a;
  vec4 tex = Texel(texture, tc);
  float dx = (0.1 * cos(anaglyphic.g * 0.3) + 0.5) / texture_details.b;
  float dy = (0.03 * sin(anaglyphic.r) + 0.03) / texture_details.a;
  vec4 red_tex = HSL(Texel(texture, tc + vec2(dx, dy)));
  vec4 blue_tex = HSL(Texel(texture, tc - vec2(dx, dy)));
  if (uv.x < 0.05 || uv.x > 0.95 || uv.y < 0.05 || uv.y > 0.95) { red_tex.a = blue_tex.a = 0.0; }
  if (red_tex.z < 0.8) { red_tex.x = 0.0; red_tex.y = 3.0; } else { red_tex.a = 0.0; }
  if (blue_tex.z < 0.8) { blue_tex.x = 0.5; blue_tex.y = 3.0; } else { blue_tex.a = 0.0; }
  if (tex.z < 0.8) { red_tex.a = blue_tex.a = 0.2; }
  if (tex.a == 0.0) { red_tex.a = blue_tex.a = 0.0; }
  if (anaglyphic.g != 0.0) { red_tex = RGB(red_tex); blue_tex = RGB(blue_tex); }
  vec4 combined = 0.5 * red_tex + 0.5 * blue_tex;
  return dissolve_mask(combined * colour, tc, uv);
}

#ifdef VERTEX
vec4 position(highp mat4 m, highp vec4 p) {
  if (hovering <= 0.0) return m * p;
  float md = length(p.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
  vec2 mo = (p.xy - mouse_screen_pos) / screen_scale;
  float sc = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - md)) * hovering * (length(mo)*length(mo)) / (2.0 - md);
  return m * p + vec4(0.0, 0.0, 0.0, sc);
}
#endif
