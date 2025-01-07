//
//  MorphingSymbolView.swift
//  Walkthrough+Morphing
//
//  Created by 김동현 on 1/6/25.
//

import SwiftUI

// MARK: - Custom Symbol Morphing View
struct MorphingSymbolView: View {
    var symbol: String
    var config: Config
    
    // MARK: - View Properties
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    var body: some View {
        // ImageView()
        
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: CGPoint(x: size.width/2, y: size.height/2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol == "" else { return }
            displayingSymbol = symbol
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in

            if let uiImage = UIImage(named: displayingSymbol) { // 커스텀 심볼 처리
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .blur(radius: radius)
                    // .scaleEffect(1 + radius / 10) // 확대 효과
                    // .opacity(1 - Double(radius) / Double(config.radius)) // 투명도 변화
                    .frame(width: config.frame.width + 200.0, height: config.frame.height + 200.0)
                    .onChange(of: radius) { oldValue, newValue in
                        if newValue.rounded() == config.radius {
                            withAnimation(config.symbolAnimation) {
                                displayingSymbol = symbol
                            }
                        }
                    }
                
            } else { // 시스템 심볼 처리
                Image(systemName: displayingSymbol)
                    .font(config.font)
                    .blur(radius: radius)
                    .foregroundStyle(config.foregroundColor)
                    .frame(width: config.frame.width, height: config.frame.height)
                    .onChange(of: radius) { oldValue, newValue in
                        if newValue.rounded() == config.radius {
                            withAnimation(config.symbolAnimation) {
                                displayingSymbol = symbol
                            }
                        }
                    }
            }
            
            
            /*
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .foregroundStyle(config.foregroundColor)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldValue, newValue in
                    if newValue.rounded() == config.radius {
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = symbol
                        }
                    }
                }
             */
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }


    }
    
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroundColor: Color
        var keyFrameDuration: CGFloat = 0.4
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
}

#Preview {
    MorphingSymbolView(symbol: "Logo", config: .init(font: .system(size: 100, weight: .bold), frame: CGSize(width: 259, height: 200), radius: 15, foregroundColor: .black))
}

#Preview {
    MorphingSymbolView(symbol: "gearshape.fill", config: .init(font: .system(size: 100, weight: .bold), frame: CGSize(width: 259, height: 200), radius: 15, foregroundColor: .black))
}


//sdas

