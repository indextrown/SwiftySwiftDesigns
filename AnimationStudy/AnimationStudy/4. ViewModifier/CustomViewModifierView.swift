//
//  CustomViewModifierView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/12/25.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .foregroundColor(.white)
    }
}

struct CustomViewModifierView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Text("Hello, World!")
                    .modifier(BorderedCaption())
                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
            }
        }
        .background(.black.gradient)
    }
}


extension View {
    // 1) view extension으로 메서드화
    func indexBorderedCaption() -> some View {
        modifier(BorderedCaption())
    }
    
    // 2) 확장에서 구현
    func indexBorderedCaption2() -> some View {
        self
            .font(.title)
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .foregroundColor(.red)
    }
}

// 3) 새로운 View를 생성
struct IndexBoardedCaptionView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .font(.title)
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .foregroundColor(.red)
        
    }
}

struct CustomViewModifierView2: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Text("Code Lounge")
                    .indexBorderedCaption()
                    // .indexBorderedCaption2()
                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
            }
        }
        .background(.black.gradient)
    }
}

#Preview {
    CustomViewModifierView2()
}

