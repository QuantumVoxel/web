#ifdef GL_ES
precision mediump float;
#endif

attribute vec3 a_position;
uniform mat4 u_projViewTrans;

attribute vec4 a_color;
attribute vec3 a_normal;
uniform mat3 u_normalMatrix;

attribute vec2 a_texCoord0;

uniform vec4 u_diffuseUVTransform;
uniform vec4 u_emissiveUVTransform;
uniform mat4 u_worldTrans;
uniform vec4 u_cameraPosition;

varying VS_varying {
    vec3 normal;
    vec2 diffuseUV;
    vec2 emissiveUV;
    vec4 color;
    vec3 position;
    float fog;
} gs_out;

void main() {
    vec2 v_diffuseUV;
    vec2 v_emissiveUV;
    vec4 v_color;
    vec3 v_position;
    float v_fog;

    v_diffuseUV = u_diffuseUVTransform.xy + a_texCoord0 * u_diffuseUVTransform.zw;
    v_position = a_position.xyz;

    v_emissiveUV = u_emissiveUVTransform.xy + a_texCoord0 * u_emissiveUVTransform.zw;

    v_color = a_color;

    #ifdef alphaTestFlag
    v_alphaTest = u_alphaTest;
    #endif //alphaTestFlag
    vec4 pos = u_worldTrans * vec4(a_position, 1.0);

    vec3 flen = u_cameraPosition.xyz - pos.xyz;
    float fog = dot(flen, flen) * u_cameraPosition.w;
    v_fog = min(fog, 1.0);

    v_diffuseUV = v_diffuseUV;
    v_emissiveUV = v_emissiveUV;
    v_color = v_color;
    v_position = v_position;
    v_normal = a_normal;
    v_fog = v_fog;

    gl_Position = u_projViewTrans * pos;
}
