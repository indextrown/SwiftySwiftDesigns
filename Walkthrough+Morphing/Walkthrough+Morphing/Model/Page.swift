////
////  Page.swift
////  Walkthrough+Morphing
////
////  Created by 김동현 on 1/6/25.
////
//
//import SwiftUI
//
//enum Page: String, CaseIterable {
//    case page1 = "playstation.logo"
//    case page2 = "gamecontroller.fill"
//    case page3 = "link.icloud.fill"
//    case page4 = "text.bubble.fill"
//    
//    var title: String {
//        switch self {
//        case .page1: "Welcome to PlayStation"
//        case .page2: "DualScnse wireless controller"
//        case .page3: "PlayStation Remove Play"
//        case .page4: "Connect With People"
//        }
//    }
//    
//    var subTitle: String {
//        switch self {
//        case .page1: "Your journey starts here"
//        case .page2: "Discover a deeper gaming experience\nwith the DualSense controller"
//        case .page3: "Stream your PS5 to Mac or\nApple devices."
//        case .page4: "Reach out and make new friends"
//        }
//    }
//    
//    var index: CGFloat {
//        switch self {
//        case .page1: 0
//        case .page2: 1
//        case .page3: 2
//        case .page4: 3
//        }
//    }
//    
//    // MARK: - Fetches the next page, if it's not the last page
//    var nextPage: Page {
//        let index = Int(self.index) + 1
//        if index < 4 {
//            return Page.allCases[index]
//        }
//        return self
//    }
//    
//    // MARK: - Fetches the previous page, if it's not first page
//    var previousPage: Page {
//        let index = Int(self.index) - 1
//        if index >= 0 {
//            return Page.allCases[index]
//        }
//        return self
//    }
//}
//"server.rack"

//
//  Page.swift
//  CodeLounge+KnowledgeHub
//
//  Created by 김동현 on 1/6/25.
//

import SwiftUI

enum Page: String, CaseIterable {
    case page1 = "leaf.circle.fill"
    // case page1 = "Logo"
    case page3 = "desktopcomputer"
    case page2 = "iphone"
    case page4 = "text.bubble.fill"
    
    var title: String {
        switch self {
        case .page1: return "코드라운지에 오신 것을 환영합니다"
        case .page3: return "컴퓨터 공학 기초 (CS)"
        case .page2: return "모바일 개발 (iOS & Android)"
        case .page4: return "코딩 팁과 모범 사례"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: return "개발자를 위한 지식 공유와 학습의 공간에 오신 것을 환영합니다."
        case .page3: return "운영체제, 네트워크, 자료구조 등 CS의 핵심 개념을 정리합니다."
        case .page2: return "iOS와 Android 개발에 필요한 필수 지식과 기술을 다룹니다."
        case .page4: return "효율적인 개발을 위한 유용한 팁과 트릭을 확인하세요."
        }
    }
    
    var description: String {
        switch self {
        case .page1:
            return """
            코드라운지는 개발자를 위한 지식 공유와 학습의 허브입니다.
            최신 기술, 심화된 개념, 실무 노하우까지
            모든 것을 이곳에서 만나보세요.
            """
        case .page3:
            return """
            컴퓨터 공학(CS)의 기본부터 심화까지 다룹니다.
            운영체제(OS), 네트워크, 자료구조, 데이터베이스 등
            개발자로서 알아야 할 모든 기초 지식을 체계적으로 학습할 수 있습니다.
            """
        case .page2:
            return """
            모바일 개발의 모든 것을 한 곳에서 배워보세요.
            iOS(Swift, UIKit, SwiftUI)와 Android(Kotlin, Jetpack Compose) 기술을 다루며,
            실무에서 바로 사용할 수 있는 내용을 제공합니다.
            """
        case .page4:
            return """
            개발 효율성을 높이고 협업을 원활하게 만드는 다양한 팁과 모범 사례를 제공합니다.
            코드 리팩토링, 디버깅, 협업 도구 활용 등 실무 중심의 정보를 확인하세요.
            """
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: return 0
        case .page3: return 1
        case .page2: return 2
        case .page4: return 3
        }
    }
    
    // MARK: - 다음 페이지 가져오기
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < Page.allCases.count {
            return Page.allCases[index]
        }
        return self
    }
    
    // MARK: - 이전 페이지 가져오기
    var previousPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
}
