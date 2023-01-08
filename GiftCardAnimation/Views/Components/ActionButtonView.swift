//
//  ActionButton.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 08/01/23.
//

import SwiftUI


struct ActionButtonView: View {
    
    var label: String
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .bold()
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.white)
                .padding(.vertical, 27)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.ColorfullGradient)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(.white, lineWidth: 2)
                        }
                }
        }
    }
}


#if DEBUG
struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(label: "VIEW BALANCE", action: {})
            .preferredColorScheme(.dark)
    }
}
#endif
