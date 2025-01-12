//
//  GeometryReaderView2.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/12/25.
//

import SwiftUI

struct GeometryReaderView2: View {
    var body: some View {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // safeAreaInsets는 기기에서 화면의 안전 영역(노치, 홈 인디케이터 등으로 인해 뷰를 침범하지 않는 영역)을 나타냅니다.
        let safeAreaInsets = scene?.windows.first?.safeAreaInsets ?? .zero // Device의 safeAreaInsets
                
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("safeAreaInsets: ").bold() + Text("\(geometry.safeAreaInsets)")
                Text("safeAreaInsets(Device): ").bold() + Text("\(safeAreaInsets)")
            }
            .padding()
        }
        .border(Color.blue, width: 3)
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("safeAreaInsets: ").bold() + Text("\(geometry.safeAreaInsets)")
            }
            .padding()
        }
        .border(Color.red, width: 3)
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("safeAreaInsets: ").bold() + Text("\(geometry.safeAreaInsets)")
            }
            .padding()
        }
        .border(Color.green, width: 3)
    }
}

#Preview {
    GeometryReaderView2()
}
