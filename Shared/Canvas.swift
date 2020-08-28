//
//  Canvas.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

struct Canvas {
    var strokes: [Stroke] = [Stroke]()
    var color: Color = Color.black
    var lineWidth: CGFloat = 3.0
    var markerMode: Bool = true
}
