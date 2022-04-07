//
//  Shader.metal
//  MetalPractice
//
//  Created by 郭毅 on 2022/4/6.
//

#include <metal_stdlib>
using namespace metal;

#include "ShaderTypes.h"

struct RasterizerData {
    float4 position [[position]];
    float4 color;
};

vertex RasterizerData
vertexShader(uint vertexID [[vertex_id]],
             constant MPVertex *vertices [[buffer(MPVertexInputIndexVertices)]],
             constant vector_uint2 *viewportSizePointer [[buffer(MPVertexInputIndexViewportSize)]]) {
    RasterizerData out;
    float2 pixelSpacePosition = vertices[vertexID].position.xy;
    vector_float2 viewportSize = vector_float2(*viewportSizePointer);
    out.position = vector_float4(0.0, 0.0, 0.0, 1.0);
    out.position.xy = pixelSpacePosition;// / (viewportSize / 2.0);
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4 fragmentShader(RasterizerData in [[stage_in]]) {
    return in.color;
}
