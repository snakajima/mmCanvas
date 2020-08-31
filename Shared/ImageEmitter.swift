//
//  ImageEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/31/20.
//

import SwiftUI

struct AnimatedImage:Hashable {
    static func == (lhs: AnimatedImage, rhs: AnimatedImage) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var image:Image
    var location:CGPoint
    var complete:()->Void
    var opacity:CGFloat = 1.0
    let id = UUID()
}

struct AnimatedImages {
    var images = Set<AnimatedImage>()
    mutating func addElement(at location:CGPoint) {
        let image = AnimatedImage(image: Image(systemName: "star"), location: location) {
            // foo
        }
        self.images.insert(image)
    }
}

struct ImageEmitter: View {
    @State var images:AnimatedImages
    var body: some View {
        VStack {
            Text("Foo " + String(images.images.count))
            /*
            let array = Array(images.images)
            ForEach(0..<array.count) { index in
                Text("Hello ")
            }
            */
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
    @State var images = AnimatedImages()
    var body: some View {
        VStack {
            Text("Hello " + String(count))
            ImageEmitter(images:images)
        }
        .background(Color(.yellow))
        .gesture(TapGesture().onEnded({ value in
            self.count = self.count + 1
        }))
    }
}
