//
//  MainView.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 02/01/23.
//

import SwiftUI


struct HomeView: View {
    
    var Content = TextContent()
    var ScratchDelegate = ScratchCardViewModel()
    
    @State var expandCard: Bool = false
    @State var showContent: Bool = false
    @State var showAnimation: Bool = false
    @State var showCardContent: Bool = false
    @State var scratched: Bool = false
    
    @Namespace var animation
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            VStack {
                // MARK: Header
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(systemName: "applelogo")
                    Text("Pay")
                }
                .font(.largeTitle.bold())
                .foregroundColor(.white)
                .alignLeft()
                
                
                // MARK: Card
                CardView(size: size)
                    .opacity(!showCardContent ? 1 : 0)
                
                // MARK: Footer
                Text(Content.congratulate)
                    .font(.system(size: 35, weight: .bold))
                
                Text(Content.info)
                    .kerning(1.02)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                
                ActionButtonView(label: "RESET") {
                    if scratched {
                        withAnimation(.easeInOut) {
                            ScratchDelegate.resetView()
                        }
                    }
                }
                .padding(.top, 15)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.Background.ignoresSafeArea())
        .overlay {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(showContent ? 1: 0)
                .ignoresSafeArea()
        }
        .overlay {
            GeometryReader { proxy in
                let cardSize = CGSize(
                    width: proxy.size.width * 0.9,
                    height: proxy.size.width * 0.9
                )
                
                VStack {
                    if expandCard {
                        GiftCardView(size: cardSize, content: Content)
                            .overlay {
                                if showAnimation {
                                    ConfettiView(fileName: "temple-confetti") { view in
                                        withAnimation(.easeInOut) {
                                            showAnimation = false
                                        }
                                    }
                                    .scaleEffect(1.4)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            .matchedGeometryEffect(id: "GIFTCARD", in: animation)
                            .onAppear(perform: showOverlay)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(.horizontal, 20)
        }
        .overlay(alignment: .topTrailing) {
            // MARK: Close Button
            Button(action: closeOverlay) {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(15)
            }
            .opacity(showContent ? 1 : 0)
            
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - View Actions
    func showOverlay() {
        withAnimation(.easeInOut(duration: 0.35)) {
            showContent = true
            showAnimation = true
        }
        showCardContent = true
    }
    
    func closeOverlay() {
        withAnimation(.easeInOut(duration: 0.35)) {
            showContent = false
            showAnimation = false
        }
        
        withAnimation(.easeInOut(duration: 0.35).delay(0.35)) {
            expandCard = false
        }
        
        withAnimation(.easeInOut(duration: 0.2).delay(0.5)) {
            showCardContent = false
        }
    }
    
    // MARK: - View Builders
    @ViewBuilder
    func CardView(size: CGSize) -> some View {
        ZStack {
            let cardSize = CGSize(
                width: size.width * 0.9,
                height: size.width * 0.9
            )
            
            ScratchCardView(
                viewModel: ScratchDelegate,
                pointSize: 60
            ) {
                if !expandCard {
                    GiftCardView(size: cardSize, content: Content)
                        .matchedGeometryEffect(
                            id: "GIFTCARD",
                            in: animation
                        )
                }
            } overlay: {
                Image.AppleCard
                    .frame(
                        width: cardSize.width,
                        height: cardSize.height
                    )
            } onFinish: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.interactiveSpring(
                        response: 0.6,
                        dampingFraction: 0.7,
                        blendDuration: 0.7)
                    ) {
                        expandCard = true
                        scratched = true
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif
