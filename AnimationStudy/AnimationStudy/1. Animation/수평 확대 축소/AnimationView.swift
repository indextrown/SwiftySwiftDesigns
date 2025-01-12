//
//  AnimationView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/11/25.
//

import SwiftUI

struct AnimationView: View {
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue.gradient)
                .frame(width: isExpanded ? 300 : 100, height: 100)
                .cornerRadius(20)
                .padding(.bottom, 30)
    
            Button {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0)) {
                    isExpanded.toggle()
                }
                
            } label: {
                Text("버튼")
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(20)
            }
        }
    }
}

#Preview {
    AnimationView()
}


