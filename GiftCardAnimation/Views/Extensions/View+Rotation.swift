//
//  View+Rotation.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 02/01/23.
//

import Foundation
import SwiftUI


struct Rotation: ViewModifier {
    @Binding var valuesArray: [Bool]
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.init(degrees: valuesArray[0] ? 4: 0), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(.init(degrees: valuesArray[1] ? 4: 0), axis: (x: 0, y: 1, z: 0))
    }
}


extension View {
    func rotate(with values: Binding<[Bool]>) -> some View {
        modifier(Rotation(valuesArray: values))
    }
}
