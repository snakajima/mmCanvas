//
//  ParticleEmitter.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/30/20.
//

import SwiftUI

struct ParticleEmitter: UIViewRepresentable {
    private var emitter = CAEmitterLayer()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.layer.addSublayer(emitter)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        emitter.emitterPosition = uiView.center
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: 100, height: 100)
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        emitter.emitterCells = [red, green, blue]
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05

        cell.contents = UIImage(systemName: "star")?.cgImage
        return cell
    }
}

struct ParticleEmitter_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Hello WOrld")
            ParticleEmitter().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
        }
    }
}
