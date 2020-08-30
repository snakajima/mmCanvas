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
}

struct Canvas {
    var strokes = [Stroke]()
    var markerMode = true
    var drawmode = DrawMode.marker
}
