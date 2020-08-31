//
//  ImageEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/31/20.
//

import SwiftUI

class ImageElement:Identifiable {
    var location:CGPoint
    let id = UUID()
    var opacity = 1.0
    init(location:CGPoint) {
        self.location = location
    }
    func startFade() {
        withAnimation {
            self.opacity = 0.3
        }
    }
}

struct ImageElements {
    var elements = [ImageElement]()
    mutating func append(_ location:CGPoint) {
        let element = ImageElement(location: location);
        elements.append(element)
        element.startFade()
    }
}

struct ImageEmitter: View {
    @Binding var elements:ImageElements
    var body: some View {
        VStack {
            ZStack {
                ForEach(elements.elements) { element in
                    Image(systemName: "star")
                        .opacity(element.opacity)
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
    @State var elements = ImageElements()
    var body: some View {
        VStack {
            ImageEmitter(elements:$elements)
        }
        .position(x:100)
        .background(Color(.yellow))
        .gesture(DragGesture().onChanged({ value in
            self.elements.append(value.location)
        }))
    }
}
