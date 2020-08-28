//
//  ContentView.swift
//  Shared
//
//  Created by SATOSHI NAKAJIMA on 8/27/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Canvas()
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
    func appendTo(path:inout Path) {
        if self.points.count == 0 {
            return
        }
        path.move(to: self.points[0])
        for point in self.points {
            path.addLine(to: point)
        }
    }
}

private let strokes2:[Stroke] = [
    Stroke(points: [CGPoint(x: 0, y:0), CGPoint(x: 200, y:100)]),
    Stroke(points: [CGPoint(x: 100, y:200), CGPoint(x: 200, y:100)]),
];

struct Canvas: View {
    @State private var strokes = [Stroke]()
    @State private var currentStroke = Stroke()
    var body: some View {
        let drag = DragGesture(minimumDistance: 0.1)
            .onChanged({ (value) in
                print(value.location);
                self.currentStroke.points.append(value.location)
            })
            .onEnded({ (value) in
                print(value.location);
                self.strokes.append(self.currentStroke)
                self.currentStroke.points.removeAll()
            })
        return GeometryReader { geometry in
            Path { path in
                for stroke in strokes2 {
                    stroke.appendTo(path: &path)
                }
                for stroke in self.strokes {
                    stroke.appendTo(path: &path)
                }
                self.currentStroke.appendTo(path: &path)
            }
            .stroke()
            .gesture(drag)
        }
        //.frame(maxHeight: .infinity)
    }
}
