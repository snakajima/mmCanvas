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
                .stroke(style:self.markerStyle)
                .fill(self.markerColor)
            Path { path in
                self.currentStroke.append(to: &path)
            }
                .stroke(style:self.currentStyle)
                .fill(self.currentColor)
            Path { path in
                self.hilite.append(to: &path)
            }
                .stroke(style:self.hiliteStyle)
                .fill(self.hiliteColor)
        }
        .background(Color(white: 0.95))
        .gesture(drag)
    }
    
    let markerStyle = StrokeStyle(lineWidth: 3.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let hiliteStyle = StrokeStyle(lineWidth: 20.0, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, miterLimit: 0.1, dash: [], dashPhase: 0)
    let markerColor = Color(.blue)
    let hiliteColor = Color(Color.RGBColorSpace.sRGB, red: 1.0, green: 0, blue: 0, opacity: 0.5)
        
    var currentColor:Color {
        return canvas.markerMode ? markerColor : hiliteColor
    }
    var currentStyle:StrokeStyle {
        return canvas.markerMode ? markerStyle : hiliteStyle
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
