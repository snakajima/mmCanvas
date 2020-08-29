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
        path.move(to: self.points.first!)
        if (self.points.count <= 2) {
            path.addLine(to: self.points.last!)
            return
        }
        for i in 1...points.count-2 {
            let point = points[i]
            let next = points[i+1]
            let mid = CGPoint(x: (point.x + next.x)/2, y: (point.y+next.y)/2)
            path.addQuadCurve(to: mid, control: point)
        }
        path.addLine(to: self.points.last!)
    }
}

struct Stroke_Previews: PreviewProvider {
    static let points = [
        CGPoint(x: 0, y: 0),
        CGPoint(x: 100, y: 0),
        CGPoint(x: 0, y: 100),
        CGPoint(x: 100, y: 100),
        CGPoint(x: 100, y: 0),
    ]
    static var previews: some View {
        VStack {
            Path {
                Stroke(points: Array(points[0..<2])).append(to:&$0)
            }
            .stroke()
            Path {
                Stroke(points: Array(points[0..<3])).append(to:&$0)
            }
            .stroke()
            Path {
                Stroke(points: Array(points[0..<4])).append(to:&$0)
            }
            .stroke()
            Path {
                Stroke(points: points).append(to:&$0)
            }
            .stroke()
        }
    }
}
