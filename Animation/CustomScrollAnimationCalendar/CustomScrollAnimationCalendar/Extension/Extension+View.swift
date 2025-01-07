//
//  Extension+View.swift
//  CustomScrollAnimationCalendar
//
//  Created by 김동현 on 1/5/25.
//

import SwiftUI

extension View {
    // 특정 달에 포함된 날짜룰 추출해 Day구조체로 이루어진 배열로 반환
    // 입력: 기준 날짜(month): 2025년 1월 5일.
    // 날짜 범위 계산: 2025년 1월의 모든 날짜를 계산: [2025-01-01, ..., 2025-01-31].
    // 각 날짜를 가공: shortSymbol으로 "일(day)" 형식 추출: "01", "02", ..., "31".
    // 결과 반환: [Day(shortSymbol: "01", date: 2025-01-01), ...].
    // MARK: - Extracting Dates for the given Month
    func extractDates(_ month: Date) -> [Day] {
        var days: [Day] = []
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        // .day 단위의 범위를 반환                                              // 범위 내 각 숫자(예: 1, 2, ..., 31)를 Date 객체로 변환
        // .day 단위로 해당 월의 날짜 범위를 계산합니다.
        //  예: 2025년 1월 → 1...31 범위 반환.
        guard let range = calendar.range(of: .day, in: .month, for: month)?.compactMap({
            value -> Date? in
            return calendar.date(byAdding: .day, value: value - 1, to: month)
        }) else {
            return days
        }
        
        let firstWeekDay = calendar.component(.weekday, from: range.first!)
        
        for index in Array(0..<firstWeekDay-1).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -index-1, to: range.first!) else { return days }
            let shortSymbol = formatter.string(from: date)
            days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
        }
        
        range.forEach { date in
            let shortSymbol = formatter.string(from: date)
            days.append(.init(shortSymbol: shortSymbol, date: date))
        }
        
        let lastWeekDay = 7 - calendar.component(.weekday, from: range.last!)
        
        if lastWeekDay > 0 {
            for index in 0..<lastWeekDay {
                guard let date = calendar.date(byAdding: .day, value: index+1, to: range.last!) else { return days }
                let shortSymbol = formatter.string(from: date)
                days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
            }
        }
        
        
        return days
    }
}
