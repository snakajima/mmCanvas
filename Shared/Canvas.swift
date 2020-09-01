//
//  Canvas.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

enum DrawMode :Int {
    case pointer = 0
    case marker = 1
    case hiliter = 2
    case emitter = 3
    case zoomer = 4
}

struct Canvas {
    var strokes = [Stroke]()
    var drawMode = DrawMode.pointer
    var url:URL? = nil
}
