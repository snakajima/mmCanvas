//
//  Canvas.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/28/20.
//

import SwiftUI

struct CanvasView: View {
    @Binding var canvas: Canvas
    @State var currentStroke = Stroke()
    @State var hilite = Stroke()

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ (value) in
                if (self.canvas.markerMode) {
                    self.canvas.strokes.append(self.currentStroke)
                } else {
                    self.hilite = self.currentStroke
                }
                self.currentStroke = Stroke()
            })
        ZStack {
            Path { path in
                for stroke in self.canvas.strokes {
                    stroke.append(to: &path)
                }
            }
            .stroke(self.canvas.color, lineWidth: self.canvas.lineWidth)
            Path { path in
                self.currentStroke.append(to: &path)
            }
            .stroke(lineWidth: self.currentLineWidth)
            .fill(self.currentColor)
            Path { path in
                self.hilite.append(to: &path)
            }
            .stroke(style:self.hiliteStyle)
            .fill(Color(.green))
        }
        .background(Color(white: 0.95))
        .gesture(drag)
    }
    
    var hiliteStyle:StrokeStyle {
        return StrokeStyle(lineWidth: 20.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    }
    var currentColor:Color {
        return canvas.markerMode ? canvas.color : Color(.red)
    }
    var currentLineWidth:CGFloat {
        return canvas.markerMode ? canvas.lineWidth : 20.0
    }
}


struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas_Instance()
    }
}

struct Canvas_Instance: View {
    @State private var canvas = Canvas(markerMode:false)
    
    var body: some View {
        VStack(alignment: .center) {
            CanvasView(canvas:$canvas)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
