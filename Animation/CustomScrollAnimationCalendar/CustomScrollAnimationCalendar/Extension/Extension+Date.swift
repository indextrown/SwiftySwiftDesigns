//
//  Extension+Date.swift
//  CustomScrollAnimationCalendar
//
//  Created by 김동현 on 1/5/25.
//

import Foundation

struct Day: Identifiable {
    var id =  UUID()
    var shortSymbol: String
    var date: Date
    var ignored: Bool = false
}

// 기존 타입에 새로운 기능 추가
extension Date {
    // static 키워드로 선언되어 인스턴스화 하지 않고 Date.currentMonth와 같이 타입 수준에서 접근 가능
    static var currentMonth: Date {
        
        // 현재 사용자의 지역 설정(시간대, 언어 등)을 기반으로 캘린더 객체를 가져온다
        let calendar = Calendar.current
        
        // 현재날짜의 월과 연도 정보를 추출한다 날짜 생성에 실패하면 현재 날짜와 시간을 기본값으로 반환한다
        guard let currentMonth = calendar.date(from: Calendar.current.dateComponents([.month, .year], from: .now)) else {
            return .now
        }
        
        // 현재 달의 첫번째 날자를 반환 2025-01-01 00:00:00
        return currentMonth
    }
    
    // 특정 Date값을 지정된 형식(format)으로 문자열로 변환하는 유틸리티 함수
    static func format(_ date: Date, _ format: String) -> String {
        
        // 날짜와 시간을 문자열로 변환하거나 문자열을 날짜로 변환시 사용
        // Swift의 날짜 포매팅 작업에서 자주 사용하는 클래스
        let formatter = DateFormatter()
        
        // 전달받은 문자열 format을 DateFormatter의 dateFormat속성에 설정
        // 속성을 yyyy-MM-dd로 설정시 2025-01-05 형식으로 변한됨
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

/*
 사용법 - currentMonth
 let firstDayOfMonth = Date.currentMonth
 print(firstDayOfMonth) // 출력: 2025-01-01 00:00:00 +0000
 
 사용법 - format()
 // 1. 현재 달의 첫 번째 날짜를 가져오기
 let firstDayOfMonth = Date.currentMonth
 print("현재 달의 첫 번째 날짜: \(firstDayOfMonth)")

 // 2. 현재 날짜를 포맷팅하여 출력하기
 let formattedDate = firstDayOfMonth.format("yyyy-MM-dd")
 print("포맷팅된 날짜: \(formattedDate)")

 // 3. 다양한 포맷 예시
 let timeFormat = firstDayOfMonth.format("HH:mm:ss")
 print("시간 포맷: \(timeFormat)")

 let fullDateFormat = firstDayOfMonth.format("EEEE, MMM d, yyyy")
 print("전체 날짜 포맷: \(fullDateFormat)")
 */




// MARK: - Date Formatter
// 특정 Date값을 지정된 형식(format)으로 문자열로 변환하는 유틸리티 함수
// input - yyyy-MM-dd
// output - String
// 사용법
// let formattedDate = format("yyyy-MM-dd")
// print(formattedDate) // 출력: "2025-01-05" (현재 날짜 기준)
// print(format("MMM dd, yyyy")) // 출력: "Jan 05, 2025"
// print(format("EEEE, MMM d, yyyy")) // 출력: "Sunday, Jan 5, 2025"
// print(format("HH:mm:ss")) // 출력: "14:35:00" (현재 시간 기준)
//func format(_ format: String) -> String {
//    
//    // 날짜와 시간을 문자열로 변환하거나 문자열을 날짜로 변환시 사용
//    // Swift의 날짜 포매팅 작업에서 자주 사용하는 클래스
//    let formatter = DateFormatter()
//    
//    // 전달받은 문자열 format을 DateFormatter의 dateFormat속성에 설정
//    // 속성을 yyyy-MM-dd로 설정시 2025-01-05 형식으로 변한됨
//    formatter.dateFormat = format
//    
//    return formatter.string(from: selectedMonth)
//}


