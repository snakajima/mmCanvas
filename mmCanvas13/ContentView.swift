//
//  ContentView.swift
//  mmCanvas13
//
//  Created by SATOSHI NAKAJIMA on 8/30/20.
//

import SwiftUI

struct ContentView: View {
    @State private var canvas = Canvas()
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
                    Image(systemName: "trash")
                }
                .disabled(self.canvas.strokes.count==0)
                Spacer()
                Picker(selection: $canvas.drawMode, label: Text("")) {
                    Image(systemName: "pencil").tag(DrawMode.marker)
                    Image(systemName: "pencil.and.outline").tag(DrawMode.hiliter)
                    //Image(systemName: "star").tag(DrawMode.emitter)
                 }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 10)
                .frame(width: 100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


