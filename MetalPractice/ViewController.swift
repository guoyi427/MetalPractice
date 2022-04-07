//
//  ViewController.swift
//  MetalPractice
//
//  Created by 郭毅 on 2022/4/6.
//

import UIKit
import MetalKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mtkView = MTKView(frame: view.bounds, device: MTLCreateSystemDefaultDevice())
        view.addSubview(mtkView)
//        mtkView.enableSetNeedsDisplay = true
//        mtkView.clearColor = MTLClearColorMake(0.5, 0.5, 0, 1)
        let renderer = Renderer(view: mtkView)
        renderer.mtkView(mtkView, drawableSizeWillChange: mtkView.drawableSize)
        mtkView.delegate = renderer
        renderer.draw(view: mtkView)
    }
}

