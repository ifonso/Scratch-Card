//
//  ConfettiView.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 07/01/23.
//

import SwiftUI
import Lottie

struct ConfettiView: UIViewRepresentable {
    
    var fileName: String
    var onFinish: (LottieAnimationView) -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupView(for: view)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func setupView(for to: UIView) {
        let animationView = LottieAnimationView(name: fileName, bundle: .main)
        
        animationView.backgroundColor = .clear
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.shouldRasterizeWhenIdle = true
        
        let constraints = [
            animationView.widthAnchor.constraint(equalTo: to.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        
        to.addSubview(animationView)
        to.addConstraints(constraints)
        
        animationView.play { _ in
            onFinish(animationView)
        }
    }
}
