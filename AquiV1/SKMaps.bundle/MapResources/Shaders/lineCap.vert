//
//  lineCap.vert
//  @brief Vertex shader used to render line caps, start and end cap, based on the line radius(half of the line width).
//
//  @note Created to work with a GL_TRIANGLES structure.
//  @note Works in world coordinates and transforms to pixels coordinates using u_scale.
//
//  Copyright (c) 2016 Skobbler. All rights reserved.
//
attribute highp vec4    a_position;
attribute mediump float a_tangents;     //cap tangent, polar form
attribute lowp float    a_lineCoord;    //encoding of coordinates of the cap points

uniform mediump vec3    u_uniforms;     //line width radius, start and end cap type
uniform mediump float   u_line_offset;  //line offset(pixels)
uniform mediump float   u_antialias;    //line antialias radius
uniform lowp vec4       u_color;
uniform highp mat4      u_mvp_matrix;
uniform highp float     u_scale;

varying mediump vec2    v_lineCoord;
varying mediump float   v_capType;

void main()
{
    mediump float w = ceil(1.25 * u_antialias)/2.0 + u_uniforms.x;
    highp float wWorld = w / u_scale;
    highp vec4 position = a_position;
    
    mediump float coord = abs(a_lineCoord);
    //invert offset cap due to flipped tangent
    mediump float flipOffset = mod(coord, 2.0);
    mediump float lineOffset = mix(-u_line_offset, u_line_offset, flipOffset);
    //check if start or end points
    mediump float u = step(2.5, coord);
    //left/right direction
    mediump float v = sign(a_lineCoord);
    
    mediump vec2 tangent = vec2(cos(a_tangents), sin(a_tangents));
    mediump vec2 o = vec2(tangent.y, -tangent.x);
    position.xy += (lineOffset / u_scale) * o;
    position.xy += v * wWorld * o;
    position.xy += u * wWorld * tangent;
    
    float notStartSegment = mod(coord, 2.0);
    if(notStartSegment > 0.5)
        v_capType = u_uniforms.z;
    else
        v_capType = u_uniforms.y;
    
    v_lineCoord = vec2(w*u, w*v);
    gl_Position = u_mvp_matrix * position;
}
