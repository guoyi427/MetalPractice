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
    
    init(view: MTKView) {
        device = view.device
        commandQueue = device?.makeCommandQueue()
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
        
    }
    
    func draw(in view: MTKView) {
        
    }
}
