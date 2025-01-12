//
//  ResultView.swift
//  AnimationStudy
//
//  Created by 김동현 on 1/9/25.
//

/*
 withAnimation vs animation(_:value:)
 withAnimation: 명시적으로 특정 이벤트에서 애니메이션 실행.
 animation(_:value:): 상태 변화와 애니메이션을 지속적으로 연결.
 transition
 삽입/제거와 관련된 애니메이션에만 사용됩니다.
 if 문으로 뷰의 존재 여부를 관리하는 상황에서 유용합니다.
 */

import SwiftUI

struct ResultView: View {
    var body: some View {
        ExpandCollapseView()
    }
}

// MARK: - withAnimation 확장/축소
struct ExpandCollapseView: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: isExpanded ? 300 : 100, height: isExpanded ? 300 : 100)
                .cornerRadius(15)

            Spacer().frame(height: 20)

            Button("Toggle Size") {
                /*
                 .easeIn
                 애니메이션이 느리게 시작하여 점점 가속합니다.

                 .easeOut
                 애니메이션이 빠르게 시작하여 점점 감속합니다.

                 .easeInOut
                 애니메이션이 느리게 시작하고 느리게 멈춤. 명시적으로 애니메이션 실행

                 .linear
                 일정한 속도로 애니메이션이 진행됩니다.
                 
                 .spring()
                 스프링 애니메이션은 실제 용수철의 움직임처럼 자연스럽고 부드러운 효과를 제공합니다.
                 
                 .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)
                 커스터마이징된 스프링
                 response: 애니메이션의 지속 시간(반응 시간).
                 dampingFraction: 얼마나 빨리 멈출지(값이 작을수록 튕김 효과).
                 blendDuration: 기존 애니메이션에서 새로운 애니메이션으로 전환되는 시간.
                 
                 .timingCurve(0.25, 0.1, 0.25, 1.0)
                 베지어 곡선을 이용해 애니메이션의 속도와 움직임을 사용자 정의할 수 있습니다.
                 입력: controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y.
                 
                 .interpolatingSpring(stiffness: 100, damping: 10)
                 interpolatingSpring
                 고급 스프링 애니메이션으로 튕기는 정도와 자연스러움을 조정.
                 stiffness: 스프링 강도(클수록 빠르게 멈춤).
                 damping: 저항 정도(작을수록 더 많이 튕김).
                 
                 
                 let customAnimation = Animation.timingCurve(0.42, 0.0, 0.58, 1.0, duration: 1.0)
                 withAnimation(customAnimation) {
                     isExpanded.toggle()
                 }
                 커스텀 애니메이션
                 SwiftUI에서 제공하는 기본 애니메이션 외에도 직접 애니메이션 곡선을 정의할 수 있습니다.
                 
                 
                 .easeIn    느리게 시작, 점점 빨라짐.
                 .easeOut    빠르게 시작, 점점 느려짐.
                 .easeInOut    느리게 시작하고 느리게 끝남.
                 .linear    일정한 속도.
                 .spring()    자연스러운 스프링 애니메이션.
                 .timingCurve    베지어 곡선을 이용한 사용자 정의 속도.
                 .interpolatingSpring    스프링 강도와 저항을 세밀하게 제어.

                 */
                let customAnimation = Animation.timingCurve(0.42, 0.0, 0.58, 1.0, duration: 1.0)
                withAnimation(customAnimation) {
                    isExpanded.toggle()
                }

            }
        }
        .padding()
    }
}

// MARK: - animation(_:value:)만 사용
struct AnimationValueExample: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.green)
                .frame(width: isExpanded ? 300 : 100, height: isExpanded ? 300 : 100)
                .cornerRadius(isExpanded ? 30 : 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isExpanded) // 상태 변화에 따라 애니메이션 적용

            Button("Toggle Size") {
                isExpanded.toggle()
            }
        }
        .padding()
    }
}

// MARK: - 뷰 추가/제거 애니메이션 transition 사용
struct AddRemoveAnimationView: View {
    @State private var isVisible: Bool = false

    var body: some View {
        VStack {
            if isVisible {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    // .transition(.scale) // 추가/제거 시 크기 애니메이션
                    //.transition(.move(edge: .top))
            }

            Spacer().frame(height: 20)

            Button("Toggle View") {
                withAnimation {
                    isVisible.toggle()
                }
            }
        }
        .padding()
    }
}

// MARK: - 위에서 아래로 나타나거나 사라지는 애니메이션
struct VerticalTransitionExample: View {
    @State private var isVisiable: Bool = false
    
    var body: some View {
        VStack {
            if isVisiable {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .cornerRadius(15)
                    .transition(.slideFromTop)
            }
            
            Spacer().frame(height: 20)
            
            Button("Toggle View") {
                withAnimation {
                    isVisiable.toggle()
                }
            }
        }
    }
}
extension AnyTransition {
    static var slideFromTop: AnyTransition {
        AnyTransition.move(edge: .top)
            .combined(with: .opacity)
    }
}

// MARK: - 위치는 그대로 유지하면서 뷰가 위에서 아래로 나타나게 하는법



#Preview {
    ResultView()
}
