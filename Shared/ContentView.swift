//
//  ContentView.swift
//  Shared
//
//  Created by SATOSHI NAKAJIMA on 8/27/20.
//

import SwiftUI

struct ContentView: View {
    static let url = Bundle.main.url(forResource: "teslaQ2_2020", withExtension: "pdf")!
    @State private var canvas = Canvas(url:url)
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
                        Picker(selection: $canvas.drawMode, label: Text("")) {
                            Image(systemName: "pencil").tag(DrawMode.marker)
                            Image(systemName: "pencil.and.outline").tag(DrawMode.hiliter)
                            Image(systemName: "star").tag(DrawMode.emitter)
                            Image(systemName: "circle").tag(DrawMode.zoomer)
                         }.pickerStyle(SegmentedPickerStyle())
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


