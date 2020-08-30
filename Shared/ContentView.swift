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
                        Button(action: { self.canvas.strokes.removeLast() }) {
                            Text("Undo")
                        }
                        .disabled(self.canvas.strokes.count==0)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: { self.canvas.strokes.removeAll() }) {
                            Image(systemName: "trash")
                        }
                        .disabled(self.canvas.strokes.count==0)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            self.canvas.markerMode.toggle()
                        }) {
                            Image(systemName: self.canvas.markerMode ? "pencil": "pencil.and.outline")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Picker(selection: $canvas.drawMode, label: Text("")) {
                            Image(systemName: "pencil").tag(DrawMode.marker)
                            Image(systemName: "pencil.and.outline").tag(DrawMode.hiliter)
                                    }.pickerStyle(SegmentedPickerStyle())                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


