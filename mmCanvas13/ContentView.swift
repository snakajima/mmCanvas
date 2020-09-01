//
//  ContentView.swift
//  mmCanvas13
//
//  Created by SATOSHI NAKAJIMA on 8/30/20.
//

import SwiftUI

struct ContentView: View {
    static let url = Bundle.main.url(forResource: "teslaQ2_2020", withExtension: "pdf")!
    @State private var canvas = Canvas(url:url)
    var body: some View {
        VStack {
            CanvasView(canvas: $canvas)
                .edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: { self.canvas.strokes.removeLast() }) {
                    Text("Undo")
                }
                .disabled(self.canvas.strokes.count==0)
                .padding(.horizontal, 10)
                Button(action: { self.canvas.strokes.removeAll() }) {
                    #if os(iOS)
                    Image(systemName: "trash")
                    #else
                    Text("Clear")
                    #endif
                }
                .disabled(self.canvas.strokes.count==0)
                Spacer()
                Picker(selection: $canvas.drawMode, label: Text("")) {
                    #if os(iOS)
                    Image(systemName: "circle.fill").tag(DrawMode.pointer)
                    Image(systemName: "pencil").tag(DrawMode.marker)
                    Image(systemName: "paintbrush").tag(DrawMode.hiliter)
                    Image(systemName: "wand.and.stars" ).tag(DrawMode.emitter)
                    Image(systemName: "magnifyingglass" ).tag(DrawMode.zoomer)
                    #else
                    Text("Point").tag(DrawMode.pointer)
                    Text("Pen").tag(DrawMode.marker)
                    Text("Brush").tag(DrawMode.hiliter)
                    Text("Spr").tag(DrawMode.emitter)
                    Text("Zoom").tag(DrawMode.zoomer)
                    #endif
                 }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)
                .frame(width: 200)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


