//
//  ShaderTypes.h
//  MetalPractice
//
//  Created by 郭毅 on 2022/4/6.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>

typedef enum MPVertexInputIndex {
    MPVertexInputIndexVertices = 0,
    MPVertexInputIndexViewportSize = 1,
} MPVertexInputIndex;
 
typedef struct {
    vector_float2 position;
    vector_float4 color;
} MPVertex;

#endif /* ShaderTypes_h */
