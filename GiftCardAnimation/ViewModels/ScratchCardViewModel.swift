//
//  ScratchCardViewModel.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 08/01/23.
//

import Foundation
import SwiftUI


class ScratchCardViewModel: ObservableObject {
    
    @Published var isScratched: Bool = false
    @Published var isGestureDisabled: Bool = false
    @Published var dragPoints: [CGPoint] = []
    @Published var animatedCard: [Bool] = [false, false]
    
    func startCardAnimation() {
        DispatchQueue.main.async {
            withAnimation(.easeIn(duration: 3).repeatForever()) {
                self.animatedCard[0] = true
            }
            
            withAnimation(.easeIn(duration: 3).repeatForever().delay(0.8)) {
                self.animatedCard[1] = true
            }
        }
    }
    
    func stopCardAnimation() {
        withAnimation(.easeIn) {
            animatedCard[0] = false
            animatedCard[1] = false
        }
    }
    
    func scratchAllCard() {
        withAnimation(.easeInOut(duration: 0.35)) {
            isScratched = true
        }
    }
    
    func disableGesture() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.isGestureDisabled = true
        }
    }
    
    func resetView() {
        isScratched = false
        isGestureDisabled = false
        dragPoints = []
        animatedCard = [false, false]
    }
}
