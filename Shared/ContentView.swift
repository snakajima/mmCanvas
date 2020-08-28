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


