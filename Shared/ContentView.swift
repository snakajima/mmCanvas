//
//  ContentView.swift
//  Shared
//
//  Created by SATOSHI NAKAJIMA on 8/27/20.
//

import SwiftUI

struct ContentView: View {
    @State private var strokes: [Stroke] = [Stroke]()
    @State private var color: Color = Color.black
    @State private var lineWidth: CGFloat = 3.0
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Canvas(strokes: $strokes,
                       color: $color,
                       lineWidth: $lineWidth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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

struct Canvas2: View {
    @State private var strokes = [Stroke]()
    @State private var currentStroke = Stroke()
    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ (value) in
                self.strokes.append(self.currentStroke)
                self.currentStroke.points.removeAll()
            })
        return GeometryReader { geometry in
            Path { path in
                path.move(to: .init(x: 0, y: 0))
                path.addLine(to: .init(x: 200, y: 10))
                for stroke in self.strokes {
                    stroke.append(to: &path)
                }
                self.currentStroke.append(to: &path)
            }
            .stroke()
            .gesture(drag)
        }
        .frame(maxHeight: .infinity)
    }
}
