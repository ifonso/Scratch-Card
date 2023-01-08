//
//  View+Image.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 08/01/23.
//

import SwiftUI

extension View {
    static var AppleCard: some View {
        Image("Apple card")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
