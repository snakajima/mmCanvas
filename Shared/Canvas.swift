//
//  Canvas.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

struct Canvas: View {
    @Binding var strokes: [Stroke]
    @Binding var color: Color
    @Binding var lineWidth: CGFloat
    @State var currentStroke = Stroke()

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for stroke in self.strokes {
                    stroke.append(to: &path)
                }
                self.currentStroke.append(to: &path)
            }
            .stroke(self.color, lineWidth: self.lineWidth)
                .background(Color(white: 0.95))
                .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            if currentPoint.y >= 0
                                && currentPoint.y < geometry.size.height {
                                self.currentStroke.points.append(currentPoint)
                            }
                        })
                        .onEnded({ (value) in
                            self.strokes.append(self.currentStroke)
                            self.currentStroke = Stroke()
                        })
            )
        }
        .frame(maxHeight: .infinity)
    }
}

