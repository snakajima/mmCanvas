//
//  ParticleEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/30/20.
//

import SwiftUI

struct ParticleEmitter: UIViewRepresentable {

    func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = "Hello World"
    }
}

struct ParticleEmitter_Previews: PreviewProvider {
    static var previews: some View {
        ParticleEmitter()
    }
}
