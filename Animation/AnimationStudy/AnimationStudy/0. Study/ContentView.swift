//
//  ContentView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/9/25.
//

/*
 Group으로한경우
 식별가능한 뷰이기때문에
 하위뷰에 각각 scale이 적용되서
 하위뷰중 하나가 사라진다면 scale transition으로 작아지는걸 볼수잇어요
 또한, frame도 하위뷰 각각에 적용되서 Text의 크기도 커진걸 알 수 있죠
  
 하지만
 VStack인경우
 scale transition동작을 하지않고
 VStack의 기본동작인 fade in / fade out (opacity) transition으로 동작해요
 왜냐하면 하위뷰가 아니라 VStack전체가 사라져야 scale transition이 동작하기 떄문이죠
 출처: https://nsios.tistory.com/184 [NamS의 iOS일기:티스토리]
 
 결론
 animation(_:value:)를 사용하면 지속적으로 특정 상태 변화에 애니메이션을 적용합니다.
 withAnimation은 버튼 클릭과 같은 특정 동작에 명시적으로 애니메이션을 추가합니다.
 둘 중 하나만 사용해야 중복 애니메이션 문제를 방지할 수 있습니다.
 추천
 단순한 상태 변화에는 animation(_:value:)를 사용하세요.
 명확하게 동작을 제어해야 한다면 withAnimation을 사용하세요.
 
 response (반응 시간)
 애니메이션의 지속 시간을 나타냅니다.
 값이 작을수록 애니메이션이 빠르게 끝납니다.
 단위: 초(second).
 예:
 response: 0.2 → 매우 빠른 애니메이션.
 response: 1.0 → 느리고 부드러운 애니메이션.
 dampingFraction (감쇠 비율)
 애니메이션의 끝부분에서 스프링이 멈추는 속도를 제어합니다.
 값은 0.0에서 1.0 사이로 설정합니다.
 값이 작을수록 더 많은 진동(튀는 효과)이 발생.
 값이 클수록 빠르게 정지.
 예:
 dampingFraction: 0.2 → 많이 튕기며 멈춤.
 dampingFraction: 0.8 → 빠르게 정지.
 blendDuration (전환 시간)
 애니메이션이 시작될 때, 기존 애니메이션에서 새 애니메이션으로 전환하는 데 걸리는 시간을 제어합니다.
 일반적으로 0으로 설정하면 자연스러운 전환이 됩니다.
 값이 클수록 기존 애니메이션과 새 애니메이션이 더 부드럽게 전환됩니다.
 
 사라지고 나타나는 애니메이션은 transition 사용
 */

import SwiftUI

struct ContentView: View {
    @State private var isVStackHidden: Bool = false
    var body: some View {
        VStack {
            //TestVStack(isHidden: $isVStackHidden)
            BasicAnimationView(isExpanded: $isVStackHidden)
        }
        .padding(.horizontal, 20)
        
        Spacer()
            .frame(height: 200)
        
        Button("변경") {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                isVStackHidden.toggle()
            }
        }
    }
}

// MARK: - Group
private struct TestGroup: View {
    @Binding var isHidden: Bool
    
    var body: some View {
        Group {
            Color.orange
            if isHidden {
                Text("Group Box")
            }
        }
        .frame(width: 200, height: 200)
    }
}

// MARK: - VStack
private struct TestVStack: View {
    @Binding var isHidden: Bool
    
    var body: some View {
        VStack {
            Color.orange
            if isHidden {
                Text("VStack Box")
            }
        }
        .frame(width: 200, height: 200)
    }
}

// MARK: - 기본 애니메이션
private struct BasicAnimationView: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isExpanded ? Color.blue : Color.red)
                .frame(width: isExpanded ? 300 : 100, height: 100)
        }
    }
}

#Preview {
    ContentView()
}



//            TestGroup(isHidden: $isVStackHidden)
//                .transition(.scale)
        
//            TestVStack(isHidden: $isVStackHidden)
//                .transition(.scale)

