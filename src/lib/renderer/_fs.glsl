precision highp float;
precision highp int;
varying vec2 vUv;

void main() {

  gl_FragColor = vec4(vUv, 1.f, 1.f);
}