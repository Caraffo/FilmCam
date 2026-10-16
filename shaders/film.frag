#version 460 core

#include <flutter/runtime_effect.glsl>

// El orden de los uniforms tiene que coincidir con FilmShaderUniforms (Dart).
uniform vec2 uSize;
uniform float uExposure;
uniform float uContrast;
uniform float uSaturation;
uniform float uFade;
uniform float uLutIntensity;
uniform float uGrain;
uniform float uGrainSize;
uniform float uVignette;
uniform float uHalation;
uniform float uSeed;
uniform float uIsFilter;
uniform vec3 uWhiteBalance;
uniform vec4 uShadowTint;
uniform vec4 uHighlightTint;

uniform sampler2D uInput;
uniform sampler2D uLut;

out vec4 fragColor;

// LUT de 64 niveles en mosaico de 8x8 sobre una textura de 512x512.
const float kLutLevels = 64.0;
const float kLutTilesPerRow = 8.0;
const float kLutTextureSize = 512.0;

const vec3 kLuma = vec3(0.2126, 0.7152, 0.0722);
// Los efectos que dependen de píxeles se escalan respecto de esta dimensión
// para que el preview y la foto final se vean iguales.
const float kReferenceDimension = 1000.0;
const int kHalationTaps = 12;
const float kHalationRadius = 0.012;
const vec3 kHalationColor = vec3(1.0, 0.35, 0.15);
const float kMaxFadeLift = 0.3;

vec2 inputUv() {
  vec2 uv = FlutterFragCoord().xy / uSize;
#ifdef IMPELLER_TARGET_OPENGLES
  if (uIsFilter > 0.5) {
    uv.y = 1.0 - uv.y;
  }
#endif
  return uv;
}

float pixelScale() {
  return min(uSize.x, uSize.y) / kReferenceDimension;
}

vec2 lutTileUv(float slice, vec2 redGreen) {
  vec2 tile = vec2(mod(slice, kLutTilesPerRow), floor(slice / kLutTilesPerRow));
  vec2 texel = tile * kLutLevels + 0.5 + redGreen * (kLutLevels - 1.0);
  return texel / kLutTextureSize;
}

vec3 applyLut(vec3 color) {
  float blue = color.b * (kLutLevels - 1.0);
  float lower = floor(blue);
  float upper = min(lower + 1.0, kLutLevels - 1.0);
  vec3 a = texture(uLut, lutTileUv(lower, color.rg)).rgb;
  vec3 b = texture(uLut, lutTileUv(upper, color.rg)).rgb;
  return mix(a, b, blue - lower);
}

vec3 halation(vec2 uv) {
  vec2 radius = kHalationRadius * min(uSize.x, uSize.y) / uSize;
  vec3 glow = vec3(0.0);
  for (int i = 0; i < kHalationTaps; i++) {
    float angle = float(i) * 6.2831853 / float(kHalationTaps);
    vec3 tap = texture(uInput, uv + vec2(cos(angle), sin(angle)) * radius).rgb;
    glow += tap * smoothstep(0.7, 1.0, dot(tap, kLuma));
  }
  return glow / float(kHalationTaps) * kHalationColor;
}

float hash(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

float valueNoise(vec2 p) {
  vec2 cell = floor(p);
  vec2 f = fract(p);
  f = f * f * (3.0 - 2.0 * f);
  float a = hash(cell);
  float b = hash(cell + vec2(1.0, 0.0));
  float c = hash(cell + vec2(0.0, 1.0));
  float d = hash(cell + vec2(1.0, 1.0));
  return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

vec3 splitTone(vec3 color, float luma) {
  float shadowWeight = 1.0 - smoothstep(0.0, 0.5, luma);
  float highlightWeight = smoothstep(0.5, 1.0, luma);
  color += (uShadowTint.rgb - 0.5) * uShadowTint.a * shadowWeight;
  color += (uHighlightTint.rgb - 0.5) * uHighlightTint.a * highlightWeight;
  return color;
}

void main() {
  vec2 uv = inputUv();
  vec3 color = texture(uInput, uv).rgb;

  color *= uWhiteBalance * exp2(uExposure);
  color += halation(uv) * uHalation;
  color = clamp(color, 0.0, 1.0);

  color = mix(color, applyLut(color), uLutIntensity);
  color = clamp((color - 0.5) * (1.0 + uContrast) + 0.5, 0.0, 1.0);

  float luma = dot(color, kLuma);
  color = mix(vec3(luma), color, 1.0 + uSaturation);
  color = splitTone(color, luma);
  color = color * (1.0 - uFade * kMaxFadeLift) + uFade * kMaxFadeLift;

  vec2 centered = uv - 0.5;
  centered.x *= uSize.x / uSize.y;
  color *= mix(1.0, smoothstep(0.85, 0.25, length(centered)), uVignette);

  vec2 grainCoord = FlutterFragCoord().xy / (uGrainSize * pixelScale());
  float grain = valueNoise(grainCoord + uSeed) - 0.5;
  float midtones = 1.0 - abs(luma * 2.0 - 1.0) * 0.5;
  color += grain * uGrain * midtones;

  fragColor = vec4(clamp(color, 0.0, 1.0), 1.0);
}
