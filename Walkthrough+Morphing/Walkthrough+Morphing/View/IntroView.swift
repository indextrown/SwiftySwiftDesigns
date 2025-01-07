//
//  IntroView.swift
//  Walkthrough+Morphing
//
//  Created by 김동현 on 1/6/25.
//

import SwiftUI

struct IntroView: View {
    // MARK: - View Properties
    @State private var activePage: Page = .page1
    @State private var dragOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack {
                Spacer(minLength: 0)
                MorphingSymbolView(
                    symbol: activePage.rawValue,
                    config: .init(
                        font: .system(size: 150, weight: .bold),
                        frame: .init(width: 250, height: 200),
                        radius: 30,
                        foregroundColor: .white))
                
                TextContents(size: size)
                
                Spacer(minLength: 0)
                
                IndicatorView()
                
                ContinueButton()
                
                
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                HeaderView()
            }
            //
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        if value.translation.width < -50 {
                            // 스와이프 왼쪽 → 다음 페이지로 이동
                            activePage = activePage.nextPage
                        } else if value.translation.width > 50 {
                            // 스와이프 오른쪽 → 이전 페이지로 이동
                            activePage = activePage.previousPage
                        }
                        dragOffset = 0
                    }
            )
            .offset(x: dragOffset) // 드래그 중인 위치 표시
            .animation(.easeInOut, value: dragOffset) // 스와이프 후 애니메이션
            //
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TextContents(size: CGSize) -> some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.title)
                        .lineLimit(1)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .kerning(1.1)
                        .frame(width: size.width)
                        .foregroundColor(.white)
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.1), value: activePage)
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) { page in
                    Text(page.subTitle)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .frame(width: size.width)
                        
                }
            }
            .offset(x: -activePage.index * size.width)
            .animation(.smooth(duration: 0.9, extraBounce: 0.1), value: activePage)
        }
        .padding(.top, 15)
        .frame(width: size.width, alignment: .leading)
    }
    
    // MARK: - Continue Button
    @ViewBuilder
    func ContinueButton() -> some View {
        Button {
            activePage = activePage.nextPage
        } label: {
            Text(activePage == .page4 ? "Login into PS App" : "Continue")
                .contentTransition(.identity)
                .foregroundStyle(.black)
                .padding(.vertical, 15)
                .frame(maxWidth: activePage == .page4 ? 220 : 180)
                .background(.white, in: .capsule)
        }
        .padding(.bottom, 15)
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
    }
    
    // MARK: - HeaderView
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                activePage = activePage.previousPage
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .contentShape(.rect)
            }
            .opacity(activePage != .page1 ? 1 : 0)
            
            Spacer(minLength: 0)
            
            Button("skip") {
                activePage = .page4
            }
            .fontWeight(.semibold)
            .opacity(activePage != .page4 ? 1 : 0)
        }
        .foregroundStyle(.white)
        .animation(.snappy(duration: 0.35, extraBounce: 0), value: activePage )
        .padding(15)
    }
    
    // MARK: - IndicatorView
    @ViewBuilder
    func IndicatorView() -> some View {
        HStack(spacing: 4) {
            ForEach(Page.allCases, id: \.rawValue) { page in
                Capsule()
                    .fill(.white.opacity(activePage == page ? 1 : 0.4))
                    .frame(width: activePage == page ? 25 : 8, height: 8  )
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: activePage)
        .padding(.bottom, 12)
    }
}

#Preview {
    IntroView()
}


//            .onTapGesture {
//                activePage = activePage.nextPage
//            }
