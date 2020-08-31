//
//  ImageEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/31/20.
//

import SwiftUI

struct ImageElement:Identifiable {
    var location:CGPoint
    let id = UUID()
}

struct ImageEmitter: View {
    @Binding var elements:[ImageElement]
    var body: some View {
        VStack {
            ZStack {
                ForEach(elements) { element in
                    Text("Foo")
                        .position(element.location)
                }
            }
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
    @State var elements = [ImageElement]()
    @State var count = 0
    var body: some View {
        VStack {
            Text("Hello " + String(count))
            ImageEmitter(elements:$elements)
        }
        .position(x:100)
        .background(Color(.yellow))
        .gesture(DragGesture().onChanged({ value in
            self.count = self.count + 1
            self.elements.append(ImageElement(location: value.location))
        }))
    }
}
