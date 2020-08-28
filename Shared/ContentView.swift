//
//  ContentView.swift
//  Shared
//
//  Created by SATOSHI NAKAJIMA on 8/27/20.
//

import SwiftUI

struct ContentView: View {
    @State private var canvas = Canvas()
    var body: some View {
        NavigationView {
            CanvasView(canvas: $canvas)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: { self.canvas.strokes.removeLast() }, label: {
                            Text("Undo")
                        })
                        .disabled(self.canvas.strokes.count==0)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: { self.canvas.strokes.removeAll() }, label: {
                            Image(systemName: "trash")
                        })
                        .disabled(self.canvas.strokes.count==0)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            self.canvas.markerMode.toggle()
                        }, label: {
                            Image(systemName: self.canvas.markerMode ? "pencil.tip": "message")
                        })
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
