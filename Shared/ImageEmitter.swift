//
//  ImageEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/31/20.
//

import SwiftUI

class ImageElement:Identifiable {
    var location:CGPoint
    init(location:CGPoint) {
        self.location = location
    }
}

struct ElementView: View {
    @State var opacity = 1.0
    var body: some View {
        Image(systemName: "star")
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.0)) {
                    self.opacity = 0.0
                }
            }
            .opacity(opacity)
    }
}

struct ImageElements {
    var elements = [ImageElement]()
    mutating func append(_ location:CGPoint) {
        let element = ImageElement(location: location);
        elements.append(element)
    }
    
    mutating func clear() {
        elements.removeAll()
    }
}

struct ImageEmitter: View {
    @Binding var elements:ImageElements
    var body: some View {
        VStack {
            ZStack {
                ForEach(elements.elements) { element in
                    ElementView()
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
        }).onEnded({ _ in
            self.elements.clear()
        }))
    }
}
