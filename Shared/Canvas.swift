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
            ZStack {
                Path { path in
                    for stroke in self.strokes {
                        stroke.append(to: &path)
                    }
                }
                .stroke(self.color, lineWidth: self.lineWidth)
                Path { path in
                    self.currentStroke.append(to: &path)
                }
                .stroke(self.color, lineWidth: self.lineWidth)

            }
            .background(Color(white: 0.95))
            .gesture(
                DragGesture(minimumDistance: 0.1)
                    .onChanged({ (value) in
                        self.currentStroke.points.append(value.location)
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


struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas_Instance()
    }
}

struct Canvas_Instance: View {
    @State private var strokes: [Stroke] = [Stroke]()
    @State private var color: Color = Color.blue
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack(alignment: .center) {
            Canvas(strokes: $strokes,
                       color: $color,
                       lineWidth: $lineWidth)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
