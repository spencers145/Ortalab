#ifdef GL_ES
  precision mediump float;
  precision mediump int;
#endif

extern vec2 overexposed;
extern float dissolve;
extern float time;
extern vec4 texture_details;
extern vec2 image_details;
extern bool shadow;
extern vec4 burn_colour_1;
extern vec4 burn_colour_2;
extern vec2 mouse_screen_pos;
extern float hovering;
extern float screen_scale;

// dissolve mask
vec4 dissolve_mask(vec4 tex, vec2 tc, vec2 uv) {
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.0) : tex.xyz,
                    shadow ? tex.a * 0.3 : tex.a);
    }
    float adjusted = (dissolve * dissolve * (3.0 - 2.0 * dissolve)) * 1.02 - 0.01;
    float t_val = time * 10.0 + 2003.0;
    vec2 base = floor(uv * texture_details.ba) / max(texture_details.b, texture_details.a);
    vec2 centered = (base - 0.5) * 2.3 * max(texture_details.b, texture_details.a);

    vec2 f1 = centered + 50.0 * vec2(sin(-t_val / 143.634), cos(-t_val / 99.4324));
    vec2 f2 = centered + 50.0 * vec2(cos(t_val / 53.1532), cos(t_val / 61.4532));
    vec2 f3 = centered + 50.0 * vec2(sin(-t_val / 87.53218), sin(-t_val / 49.0));
    float field = (1.0 + (
        cos(length(f1) / 19.483) +
        sin(length(f2) / 33.155) * cos(f2.y / 15.73) +
        cos(length(f3) / 27.193) * sin(f3.x / 21.92)
    )) * 0.5;
    vec2 borders = vec2(0.2, 0.8);
    float res = (0.5 + 0.5 * cos(adjusted / 82.612 + (field - 0.5) * 3.14))
        - (base.x > borders.y ? (base.x - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (base.y > borders.y ? (base.y - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (base.x < borders.x ? (borders.x - base.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (base.y < borders.x ? (borders.x - base.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve;

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow &&
        res > adjusted &&
        res < adjusted + 0.8 * (0.5 - abs(adjusted - 0.5))) {
        tex = (res < adjusted + 0.5 * (0.5 - abs(adjusted - 0.5)))
            ? burn_colour_1
            : (burn_colour_2.a > 0.01 ? burn_colour_2 : tex);
    }
    return vec4(shadow ? vec3(0.0) : tex.xyz,
                res > adjusted ? (shadow ? tex.a * 0.3 : tex.a) : 0.0);
}

// hue helper
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
    float tVal = (c.z < 0.5) ? c.y * c.z + c.z : -c.y * c.z + (c.y + c.z);
    float sVal = 2.0 * c.z - tVal;
    return vec4(
        hue(sVal, tVal, c.x + 1.0 / 3.0),
        hue(sVal, tVal, c.x),
        hue(sVal, tVal, c.x - 1.0 / 3.0),
        c.w
    );
}

// HSL conversion
vec4 HSL(vec4 c) {
    float lo = min(c.r, min(c.g, c.b));
    float hi = max(c.r, max(c.g, c.b));
    float d = hi - lo;
    float sumVal = hi + lo;
    vec4 hsl = vec4(0.0, 0.0, 0.5 * sumVal, c.a);
    if (d == 0.0) return hsl;
    hsl.y = (hsl.z < 0.5) ? d / sumVal : d / (2.0 - sumVal);
    if (hi == c.r) hsl.x = (c.g - c.b) / d;
    else if (hi == c.g) hsl.x = (c.b - c.r) / d + 2.0;
    else hsl.x = (c.r - c.g) / d + 4.0;
    hsl.x = mod(hsl.x / 6.0, 1.0);
    return hsl;
}

// Reinhard tone mapping
vec3 reinhardToneMap(vec3 color, float exposure) {
    color *= exposure / (1.0 + color / exposure);
    color = pow(color, vec3(1.0 / 2.2));
    return color;
}

// main effect
vec4 effect(mediump vec4 colour, Image texture, mediump vec2 tc, mediump vec2 sc) {
    vec4 tex = Texel(texture, tc);
    vec4 baseTex = tex;
    vec2 uv = (tc * image_details - texture_details.xy * texture_details.ba)
              / texture_details.ba;
    float t_anim = overexposed.g + time;
    if (tex.a > 0.0) {
        vec3 color = tex.rgb;
        float rate = 1.5 - uv.y - 0.3 * sin(0.8 * t_anim);
        if (rate > 1.0) {
            rate = 1.0 - mod(rate, 1.0);
        }
        color *= (2.3 * rate);
        vec3 newColor = reinhardToneMap(color, 1.5);
        tex = vec4(newColor, 1.0);
        float ratio = 0.9;
        tex = ratio * tex + (1.0 - ratio) * baseTex;
    }
    return dissolve_mask(tex * colour, tc, uv);
}

#ifdef VERTEX
vec4 position(highp mat4 transform_projection, highp vec4 vertex_position) {
    if (hovering <= 0.0) return transform_projection * vertex_position;
    float mid = length(vertex_position.xy - 0.5 * love_ScreenSize.xy)
              / length(love_ScreenSize.xy);
    vec2 offset = (vertex_position.xy - mouse_screen_pos) / screen_scale;
    float scale = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - mid))
                * hovering * dot(offset, offset) / (2.0 - mid);
    return transform_projection * vertex_position + vec4(0.0, 0.0, 0.0, scale);
}
#endif
