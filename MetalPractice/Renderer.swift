//
//  Renderer.swift
//  MetalPractice
//
//  Created by 郭毅 on 2022/4/6.
//

import MetalKit

class Renderer: NSObject {
    fileprivate var device: MTLDevice?
    fileprivate var commandQueue: MTLCommandQueue?
    fileprivate var pipelineState: MTLRenderPipelineState?
    fileprivate var viewportSize: vector_uint2 = vector_uint2(0, 0)
    
    init(view: MTKView) {
        guard let device = view.device else {
            debugPrint("device is nil")
            return
        }
        guard let defaultLibrary = device.makeDefaultLibrary() else {
            debugPrint("default library is nil")
            return
        }
        let vertexFunction = defaultLibrary.makeFunction(name: "vertexShader")
        let fragmentFunction = defaultLibrary.makeFunction(name: "fragmentShader")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "guoyiPipe"
        pipelineStateDescriptor.vertexFunction = vertexFunction
        pipelineStateDescriptor.fragmentFunction = fragmentFunction
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch {
            debugPrint(error)
        }
        
        commandQueue = device.makeCommandQueue()
    }
    
    func draw(view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            debugPrint("render pass descriptor is nil")
            return
        }
        guard let commandBuffer = commandQueue?.makeCommandBuffer() else {
            debugPrint("make command buffer failure")
            return
        }
        guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            debugPrint("make render command encoder failure")
            return
        }
        
        guard let pipelineState = pipelineState else {
            return
        }
        
        commandEncoder.setViewport(MTLViewport(originX: 0, originY: 0, width: Double(viewportSize.x), height: Double(viewportSize.y), znear: 0, zfar: 1))
        commandEncoder.setRenderPipelineState(pipelineState)
        
        let vertex0 = MPVertex(position: vector_float2(-1, -1), color: vector_float4(1, 0, 0, 1))
        let vertex1 = MPVertex(position: vector_float2(1, -1), color: vector_float4(0, 1, 0, 1))
        let vertex2 = MPVertex(position: vector_float2(0, 1), color: vector_float4(0, 0, 1, 1))
        let triangleVertices: [MPVertex] = [vertex0, vertex1, vertex2]
        
        commandEncoder.setVertexBytes(triangleVertices, length: MemoryLayout.size(ofValue: vertex0) * triangleVertices.count, index: Int(MPVertexInputIndexVertices.rawValue))
        commandEncoder.setVertexBytes(&viewportSize, length: MemoryLayout.size(ofValue: viewportSize), index: Int(MPVertexInputIndexViewportSize.rawValue))
        
        commandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        commandEncoder.endEncoding()
        guard let drawable = view.currentDrawable else {
            debugPrint("current drawable is nil")
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        viewportSize.x = UInt32(size.width)
        viewportSize.y = UInt32(size.height)
    }
    
    func draw(in view: MTKView) {
        
    }
}
