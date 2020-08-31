//
//  ImageEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/31/20.
//

import SwiftUI

struct ImageEmitter: View {
    var body: some View {
        VStack {
            Text("Foo")
        }
    }
}

struct ImageEmitter_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageEmitter_Test()
        }
    }
}

struct ImageEmitter_Test: View {
    @State var count = 0
    var body: some View {
        VStack {
            Text("Hello " + String(count))
            ImageEmitter()
        }
        .position()
        .background(Color(.yellow))
        .gesture(DragGesture().onChanged({ value in
            self.count = self.count + 1
        }))
    }
}
