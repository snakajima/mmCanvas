//
//  Canvas.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

enum DrawMode :Int {
    case marker = 0
    case hiliter = 1
    case zoomer = 2
    case emitter = 3
}

struct Canvas {
    var strokes = [Stroke]()
    var drawMode = DrawMode.marker
    var url:URL? = nil
}
