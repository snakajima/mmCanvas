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
    @State var dragging = false
    @State var location = CGPoint.zero

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ value in
                self.dragging = true
                self.location = value.location
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ value in
                self.dragging = false
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
        GeometryReader { (geometry) in
            ZStack {
                MyPDFView(self.canvas.url)
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
                //ParticleEmitter()
                if self.canvas.drawMode == .zoomer && self.dragging {
                    let radius = min(geometry.size.width, geometry.size.height)/3
                    MyPDFView(self.canvas.url)
                        .scaleEffect(10.0)
                        .frame(width:radius,height:radius)
                        .clipShape(Circle())
                        .position(self.location)
                }
            }
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
    static let url = Bundle.main.url(forResource: "teslaQ2_2020", withExtension: "pdf")!
    @State private var canvas = Canvas(drawMode:DrawMode.zoomer, url:url)
    
    var body: some View {
        VStack(alignment: .center) {
            CanvasView(canvas:$canvas)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
