//
//  GeometryProxyView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/12/25.
//

/*
 reference
 - https://swifty-cody.tistory.com/154
 - https://nyancoder.tistory.com/20
 geometryReader
 - 부모view 사이즈를 알고 해당 좌표계에 따라서 그릴 수 있다
 - 자식View에 자신의 크기와 좌표공간을 제공 및 이를 이용해서 정의할 수 있도록 도와주는 View
 - content 클로저로 자신의 size, frame(iOS7+), safeAreaInsets등 자식 View를 그리는데 필요한 정보 GeometryProxy를 전달한다

 */


import SwiftUI

struct GeometryProxyView: View {
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("geometry 정보")
                    .font(.title)
                Text("size: ").bold() + Text("\(geometry.size)")
                Text("frame: ").bold() + Text("\(geometry.frame(in: .local).dictionaryRepresentation)")
                Text("safeAreaInsets: ").bold() + Text("\(geometry.safeAreaInsets)")
            }
            .padding()
            
            // (0, 0)
            Circle()
                .fill(Color.red) // 점의 색상
                .frame(width: 500, height: 50) // 점의 크기
                .overlay {
                    Text("(0, 0)")
                }
                .position(x: 0, y: 0) // 원하는 위치에 점 표시
            
            // (200, 0)
            Circle()
                .fill(Color.red) // 점의 색상
                .frame(width: 500, height: 50) // 점의 크기
                .overlay {
                    Text("(200, 0)")
                }
                .position(x: 200, y: 0) // 원하는 위치에 점 표시
            
            // (0, 200)
            Circle()
                .fill(Color.red) // 점의 색상
                .frame(width: 500, height: 50) // 점의 크기
                .overlay {
                    Text("(0, 200)")
                }
                .position(x: 0, y: 200) // 원하는 위치에 점 표시
                
        }
        //.ignoresSafeArea()
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(Color.white, width: 3)
        .foregroundColor(.white)
        .background(.black.gradient)
    }
}

#Preview {
    GeometryProxyView()
}
