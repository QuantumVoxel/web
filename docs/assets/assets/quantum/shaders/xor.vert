#ifdef GL_ES
precision highp float;
precision highp int;
#endif

attribute vec4 a_position;
attribute vec2 a_texCoord0;
uniform mat4 u_projTrans;
varying vec2 v_texCoord0;

void main() {
    v_texCoord0 = a_texCoord0;
    gl_Position = u_projTrans * a_position;
}