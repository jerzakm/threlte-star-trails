precision highp float;
precision highp int;

#include <packing>
#include <common>

varying vec2 vUv;
uniform sampler2D liveScene;
uniform sampler2D previousFinalRender;

void main() {
  vec4 currentFrame = texture2D(liveScene, vUv);
  vec4 prevFrame = texture2D(previousFinalRender, vUv);

  float fadeAmount = 0.994f;
  vec4 fadedPrev = prevFrame * fadeAmount;

  float brightness = dot(currentFrame.rgb, vec3(0.299f, 0.587f, 0.114f));
  float fadeMod = mix(fadeAmount, 1.0f, brightness);

  gl_FragColor = fadedPrev * fadeMod + currentFrame;
  gl_FragColor = min(gl_FragColor, vec4(1.0f));
}
