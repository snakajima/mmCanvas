//
//  Stroke.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

struct Stroke {
    var points = [CGPoint]()
    func append(to path:inout Path) {
        if self.points.count == 0 {
            return
        }
        path.move(to: self.points[0])
        for point in self.points {
            path.addLine(to: point)
        }
    }
}
