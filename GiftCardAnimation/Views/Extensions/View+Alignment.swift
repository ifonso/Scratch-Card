//
//  View+Alignment.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 08/01/23.
//

import Foundation
import SwiftUI


extension View {
    @ViewBuilder
    func alignLeft() -> some View {
        HStack {
            self
            Spacer()
        }
    }
}
