//
//  GiftCardView.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 08/01/23.
//

import SwiftUI

struct GiftCardView: View {
    
    var size: CGSize
    var content: TextContent
    
    var body: some View {
        VStack(spacing: 18) {
            Image("Star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            
            Text(content.congratulateCard)
                .font(.body)
                .foregroundColor(.gray)
            
            HStack {
                Image(systemName: "applelogo")
                Text(content.prize)
            }
            .font(.title.bold())
            .foregroundColor(.black)
            
            Spacer()
            
            Text(content.prizeInfo)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(20)
        .frame(
            width: size.width,
            height: size.height
        )
        .background {
            RoundedRectangle(cornerRadius: 16).fill(.white)
        }
    }
}


#if DEBUG
struct GiftCardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            let cardSize = CGSize(
                width: proxy.size.width * 0.9,
                height: proxy.size.width * 0.9
            )
            
            GiftCardView(
                size: cardSize,
                content: TextContent()
            )
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
        .preferredColorScheme(.dark)
    }
}
#endif
