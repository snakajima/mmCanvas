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

    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ (value) in
                self.canvas.strokes.append(self.currentStroke)
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
            .stroke(self.canvas.color, lineWidth: self.canvas.lineWidth)
        }
        .background(Color(white: 0.95))
        .gesture(drag)
    }
}


struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas_Instance()
    }
}

struct Canvas_Instance: View {
    @State private var canvas = Canvas()
    
    var body: some View {
        VStack(alignment: .center) {
            CanvasView(canvas:$canvas)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
