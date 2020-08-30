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
    @State var opacity = 0.0

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ value in
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ value in
                if (self.canvas.drawMode == .marker) {
                    self.canvas.strokes.append(self.currentStroke)
                } else if  (self.canvas.drawMode == .hiliter) {
                    self.hilite = self.currentStroke
                    self.opacity = 1.0
                    withAnimation {
                        self.opacity = 0.0
                    }
                }
                self.currentStroke = Stroke()
            })
        ZStack {
            Path {
                for stroke in self.canvas.strokes {
                    stroke.append(to: &$0)
                }
            }
                .stroke(style:self.markerStyle)
                .fill(self.markerColor)

            if (self.canvas.drawMode == .marker) {
                Path {
                    self.currentStroke.append(to: &$0)
                }
                    .stroke(style:self.markerStyle)
                    .fill(self.markerColor)

            } else if (self.canvas.drawMode == .hiliter) {
                Path {
                    self.currentStroke.append(to: &$0)
                }
                    .stroke(style:self.hiliteStyle)
                    .fill(self.hiliteColor)
                    .blur(radius:2)
            }
            Path {
                self.hilite.append(to: &$0)
            }
                .stroke(style:self.hiliteStyle)
                .fill(self.hiliteColor)
                .blur(radius:2)
            .opacity(self.opacity)
                .animation(.easeOut)
        }
        .background(Color(white: 0.95))
        .gesture(drag)
    }
    
    let markerStyle = StrokeStyle(lineWidth: 3.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let hiliteStyle = StrokeStyle(lineWidth: 30.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let markerColor = Color(.blue)
    let hiliteColor = Color(Color.RGBColorSpace.sRGB, red: 1.0, green: 0, blue: 0, opacity: 0.2)
}



struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas_Instance()
    }
}

struct Canvas_Instance: View {
    @State private var canvas = Canvas(drawMode:DrawMode.hiliter)
    
    var body: some View {
        VStack(alignment: .center) {
            CanvasView(canvas:$canvas)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
