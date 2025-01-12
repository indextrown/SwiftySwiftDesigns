//
//  GeometryReaterView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/12/25.
//

import SwiftUI

struct GeometryReaterView: View {
    var body: some View {
        GeometryReader { geometry in
            Text("geometry 정보")
                .background(Color.red)
                .font(.title)
            // frame 정의
            // 뷰의 크기(너비/높이) 또는 정렬
                .frame(width: geometry.size.width, alignment: .center)
            
            
            Text("size: \(geometry.size)")
                .background(Color.green)
            // offset 정의
            // 뷰를 현재 위치에서 상대적으로 이동
            // 뷰의 원래 공간을 그대로 유지하면서 화면에서 시각적으로만 이동
            // 레이아ㅏ웃 계산에 영향을 미치지 않는다
                .offset(y: 60)
                
            Text("frame: \(geometry.frame(in: .local).dictionaryRepresentation)")
                .background(Color.yellow)
            // position 정의
            // 뷰의 anchor를 기준으로 화면에서 절대 위치를 설정
            // 부모 뷰의 좌표 공간 GeometryReader 를 기준으로 동작
            // 배치된 뷰의 기본 위치를 무시하고 특정 좌표에 뷰를 매치
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
        .padding()
        .border(Color.blue, width: 3)
    }
}

#Preview {
    GeometryReaterView()
}
