//
//  ScratchCardView.swift
//  GiftCardAnimation
//
//  Created by Afonso Lucas on 02/01/23.
//

import SwiftUI



struct ScratchCardView<Content: View, Overlay: View>: View {
    
    var content: Content
    var overlay: Overlay
    
    var pointSize: CGFloat
    var onFinish: () -> ()
    
    @ObservedObject var vm: ScratchCardViewModel
    
    init(
        viewModel: ScratchCardViewModel,
        pointSize: CGFloat,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlay: @escaping () -> Overlay,
        onFinish: @escaping () -> ())
    {
        self.vm = viewModel
        self.content = content()
        self.overlay = overlay()
        self.pointSize = pointSize
        self.onFinish = onFinish
    }
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                overlay
                    .opacity(vm.isGestureDisabled ? 0 : 1)
                content
                    .mask { getMask(size: size) }
                    .gesture(DragGesture(minimumDistance: vm.isGestureDisabled ? 100000 : 0)
                        .onChanged { value in
                            // Stop animation
                            if vm.dragPoints.isEmpty { vm.stopCardAnimation() }
                            // Add points
                            vm.dragPoints.append(value.location)
                        }
                        .onEnded { _ in
                            if !vm.dragPoints.isEmpty {
                                // Scratch all card
                                vm.scratchAllCard()
                                // Callback
                                onFinish()
                            }
                        }
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .rotate(with: $vm.animatedCard)
            .onAppear(perform: vm.startCardAnimation)
        }
    }
    
    // MARK: - View Functions
    @ViewBuilder
    func getMask(size: CGSize) -> some View {
        if vm.isGestureDisabled {
            Rectangle()
        } else {
            PointShape(points: vm.dragPoints)
                .stroke(style: getStrokeStyle(size: size.width))
        }
    }
    
    func getStrokeStyle(size: CGFloat) -> StrokeStyle {
        StrokeStyle(
            lineWidth: vm.isScratched ? (size * 1.4) : pointSize,
            lineCap: .round,
            lineJoin: .round
        )
    }
}


struct PointShape: Shape {
    
    var points: [CGPoint]
    var animatableData: [CGPoint] {
        get { points }
        set { points = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            if let first = points.first {
                path.move(to: first)
                path.addLines(points)
            }
        }
    }
}


#if DEBUG
struct ScratchCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ScratchCardView(viewModel: ScratchCardViewModel(), pointSize: 60) {
                ZStack {
                    Color.white
                    Text("Test").foregroundColor(.black)
                }
                .cornerRadius(16)
            } overlay: {
                Color.blue.cornerRadius(16)
            } onFinish: {}
            .frame(width: 300, height: 300)
            .padding(16)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
