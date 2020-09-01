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
    @State var isDragging = false
    @State var location = CGPoint.zero
    @State var elements = ImageElements()

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ value in
                self.isDragging = true
                self.location = value.location
                self.currentStroke.points.append(value.location)
                if self.canvas.drawMode == .emitter {
                    self.elements.append(value.location)
                }
            })
            .onEnded({ value in
                self.isDragging = false
                if self.canvas.drawMode == .marker {
                    self.canvas.strokes.append(self.currentStroke)
                } else if self.canvas.drawMode == .hiliter {
                    self.hilite = self.currentStroke
                    self.opacity = 1.0
                    withAnimation {
                        self.opacity = 0.0
                    }
                } else if self.canvas.drawMode == .emitter {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.elements.clear()
                    }
                }
                self.currentStroke = Stroke()
            })
        GeometryReader { geometry in
            ZStack {
                #if os(iOS)
                MyPDFView(self.canvas.url)
                #endif
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
                ImageEmitter(elements:$elements)
                //ParticleEmitter()
                if isDragging {
                    if self.canvas.drawMode == .zoomer {
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let radius = max(width, height) / 2.0
                        let anchorX = (location.x / width - 0.5) * 1.2 + 0.5
                        let anchorY = (location.y / height - 0.5) * 1.2 + 0.5
                        let x = min(max(location.x, (location.x + width * 0.25) / 2.0),
                                    (location.x + width * 0.75) / 2.0)
                        let y = min(max(location.y, (location.y + height * 0.25) / 2.0),
                                    (location.y + height * 0.75) / 2.0)
                        #if os(iOS)
                        MyPDFView(canvas.url)
                            .scaleEffect(5.0, anchor: UnitPoint(x:anchorX, y:anchorY))
                            .frame(width:radius,height:radius)
                            .clipShape(Circle())
                            .position(CGPoint(x:x,y:y))
                        #endif
                    } else if self.canvas.drawMode == .pointer {
                        #if os(iOS)
                        Image(systemName:"circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .opacity(0.333)
                            .scaledToFit()
                            .frame(width:50, height:50)
                            .position(location)
                        #endif
                    }
                }
            }
        }
        .background(Color(white: 0.95))
        .gesture(drag)
    }
    
    let markerStyle = StrokeStyle(lineWidth: 3.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let hiliteStyle = StrokeStyle(lineWidth: 30.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let markerColor = Color(.blue)
    let hiliteColor = Color(Color.RGBColorSpace.sRGB, red: 0.0, green: 0, blue: 1.0, opacity: 0.2)
}



struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas_Instance()
    }
}

struct Canvas_Instance: View {
    static let url = Bundle.main.url(forResource: "teslaQ2_2020", withExtension: "pdf")!
    @State private var canvas = Canvas(drawMode:DrawMode.pointer, url:url)
    
    var body: some View {
        VStack(alignment: .center) {
            CanvasView(canvas:$canvas)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
