//
//  HomeView.swift
//  CustomScrollAnimationCalendar
//
//  Created by 김동현 on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    // MARK: - View Properties
    @State private var selectedMonth: Date = .currentMonth  // 현재 월의 첫번째 날짜 반환
    @State private var selectedDate: Date = .now
    
    
    var safearea: EdgeInsets
    var body: some View {
        let maxHeight = calenDarHeight - (calendarTitleViewHeight + weekLabelHeight + safearea.top + 50 + topPadding + bottomPadding - 50)
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                CalendarView()
                
                VStack(spacing: 15) {
                    ForEach(1...15, id: \.self) { _ in
                        CardView()
                    }
                }
                .padding(15)
                .background(.white)
                .cornerRadius(20)
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(CustomScrollBehavior(maxHeight: maxHeight))
        .background(.black)
    }
    
    // MARK: - Test Card View
    @ViewBuilder
    func CardView() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.mainGray.gradient)
            .frame(height: 70)
            .overlay(alignment: .leading) {
                HStack(spacing: 12) {
                    Circle()
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 70, height: 5)
                    }
                }
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white.opacity(0.25), Color.mainBlack.opacity(0.4)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(15)
            }
    }
    
    // MARK: - CalendarView
    @ViewBuilder
    func CalendarView() -> some View {
        GeometryReader {
            // $0는 GeometryProxy 객체를 나타내고 현재 뷰의 레이아웃 정보를 포함한다
            // size: 뷰의 크기(너비 & 높이) -> size.width size.height
            let size = $0.size
            
            // 특정 좌표 공간에서 뷰의 위치를 반환.
            // frame(in:); 특정 좌표 공간에서 뷰의 크기와 위치를 나타내는 CGRect를 반환
            // .scrollView(axis: .vertical): 뷰가 스크롤 뷰 안에 있을 경우 스크롤 뷰 좌표 공간을 기준으로 위치 계산
            // axis: .vertical: 수직 방향에서 위치 측정
            // minY: 뷰의 상단Y좌표를 반환(맨위에있으면 minY = 0 아래로 스크롤되면 minY값이 음수가 됨)
            // 스크롤에 따라 뷰의 위치를 계산하거나 특정 애니메이션을 트리거 할 때 활용
            // 정리
            // size를 통해 현재 뷰의 너비와 높이를 가져옴
            // minY를 통해 스크롤 뷰에서의 Y축 위치를 계산
            // size와 minY 정보를 사용해 동적 레이아웃, 애니메이션, 또는 스크롤 기반의 이벤트를 처리
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY //
            
            // 뷰의 최대 높이를 계산하는 변수로, 스크롤 진행 상태를 계산하기 위한 기준점입니다.
            let maxHeight = size.height - (calendarTitleViewHeight + weekLabelHeight + safearea.top + 50 + topPadding + bottomPadding - 50)
            
            
            let progress = max(min((-minY/maxHeight), 1), 0)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(currentMonth)
                    .font(.system(size: 35 - (10 * progress)))
                    .offset(y: -50 * progress)
                    .frame(maxHeight: .infinity, alignment: .bottom) // 프레임 높이 확장, 아래쪽 정렬
                    .overlay(alignment: .topLeading) {
                        GeometryReader { // 뷰 크기를 읽어오기 위해 사용
                            let size = $0.size // 현재 뷰의 크기
                            
                            Text(year)
                                .font(.system(size: 25 - (10 * progress)))
                                .offset(x: (size.width + 5) * progress, y: progress * 3)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // 최대 너비 확장, 왼쪽 정렬
                    .overlay(alignment: .topTrailing) {
                        HStack(spacing: 15) {
                            Button {
                                monthUpdate(false)
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            //.contentShape(.rect)
                            
                            Button {
                                monthUpdate(true)
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                            //.contentShape(.rect)
                        }
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .offset(x: 150 * progress)
                    }
                    .frame(height: calendarTitleViewHeight)  // 제목 영역의 높이를 고정 (75.0)
                
                VStack(spacing: 0) {
                    // MARK: - Day Labels
                    HStack(spacing: 0) {
                        ForEach(Calendar.current.weekdaySymbols, id: \.self) { symbol in
                            Text(symbol.prefix(3))
                                .font(.caption)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: weekLabelHeight, alignment: .bottom)
                    
                    // MARK: - Calendar Grid View
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0, content: {
                        ForEach(selectedMonthDates) { day in
                            Text(day.shortSymbol)
                                .foregroundStyle(day.ignored ? .secondary : .primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .overlay(alignment: .bottom) {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 5, height: 5)
                                        .opacity(Calendar.current.isDate(day.date, inSameDayAs: selectedDate) ? 1 : 0)
                                        .offset(y: progress * -2)
                                }
                                .contentShape(.rect)
                                .onTapGesture {
                                    selectedDate = day.date
                                }
                        }
                    })
                    .frame(height: calendarGridHeight - ((calendarGridHeight - 50) * progress), alignment: .top)
                    .offset(y: (monthProgress * -50) * progress)
                    .contentShape(.rect)
                    .clipped()
                }
                .offset(y: progress * -50)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, horizontalPadding)    // 좌우 여백 추가 (15)
            .padding(.top, topPadding)                  // 상단 여백 추가 (15)
            .padding(.top, safearea.top)                // 뷰의 상단에 안전 영역만큼의 여백을 추가
            .padding(.bottom, bottomPadding)            // 하단 여백 추가 (5)
            .frame(maxHeight: .infinity)
            .frame(height: size.height - (maxHeight * progress), alignment: .top)
            .background(.black.gradient)
            .clipped()                                  // 뷰 경계 밖의 여백 제거
            .contentShape(.rect)
            .offset(y: -minY)                           // 뷰를 수직 방향으로 이동(양수: 아래로 이동 음수: 위로이동)
          
        }
        .frame(height: calenDarHeight)
        .zIndex(1000)
    }
    
    // MARK: - Month Increment/Decrement
    func monthUpdate(_ increment: Bool = true) {
        
        // 현재 사용자의 로컬 설정(시간대, 캘린더 등)에 맞는 캘린더 객체를 가져온다.
        let calendar = Calendar.current
        
        // 현재 월(`selectedMonth`)에서 전달받은 값에 따라 월을 증가 또는 감소시킨다.
        guard let month = calendar.date(
            byAdding: .month,               // 단위: 월(month)
            value: increment ? 1 : -1,      // `increment`가 true면 +1, false면 -1
            to: selectedMonth               // 기준 날짜
        ) else { return }                   // 날짜 계산에 실패하면 함수 종료
        
        // 계산된 날짜(`month`)를 `selectedMonth`로 업데이트
        selectedMonth = month
    }
    
    // MARK: - Selected Month Dates
    var selectedMonthDates: [Day] {
        return extractDates(selectedMonth)
    }
    
    // MARK: - CurrentMonth: String
    var currentMonth: String {
        return Date.format(selectedMonth, "MMMM")
    }
    
    // MARK: - Selected Year
    var year: String {
        return Date.format(selectedMonth, "YYYY")
    }
    
    // MARK: - 특정 날짜가 선택된 열에서 어느 정도 진행되었는가
    var monthProgress: CGFloat {
        // 현재 시스템 달력 가져온다
        let calendar = Calendar.current
        
        // 사용자가 선택한 selectedDate가 selectedMonthDates 배열에서 몇 번째에 위치하는지 확인
        // 해당 인덱스를 주 단위로 나눈 후 반올림하여 월의 진행도를 계산.
        // selectedDate를 찾을 수 없으면 월의 진행도를 1.0(기본값)으로 설정.
        if let index = selectedMonthDates.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: selectedDate) }) {
            return CGFloat(index / 7).rounded() // 반올림
        }
        return 1.0
    }
    
    // MARK: - 전체 캘린더 높이 = 캘린더 제목 + 요일 레이블 + 캘린더 그리드 높이 + 안전 영역 + 상단여백 + 하단여백
    var calenDarHeight: CGFloat {
        return calendarTitleViewHeight + weekLabelHeight + calendarGridHeight + safearea.top + topPadding + bottomPadding
    }
    
    // 캘린더 제목 영역 높이
    var calendarTitleViewHeight: CGFloat {
        return 75.0
    }
    
    // 요일 레이블 높이(예: "월, 화, 수")
    var weekLabelHeight: CGFloat {
        return 30.0
    }
    
    // 캘린더 그리드 높이 - 31인 경우 4개의 행
    var calendarGridHeight: CGFloat {
        return CGFloat(selectedMonthDates.count / 7) * 50
    }
    
    // MARK: - 좌우 여백(캘린더 내용의 양쪽)
    var horizontalPadding: CGFloat {
        return 15.0
    }
    
    // 상단 여백(캘린더 내용 상단)
    var topPadding: CGFloat {
        return 15.0
    }
    
    // 하단 여백(캘린더 내용 하단)
    var bottomPadding: CGFloat {
        return 5.0
    }
}

//#Preview {
//    HomeView(safearea: .init())
//}
 
// MARK: - Custom Scroll Behavior
struct CustomScrollBehavior: ScrollTargetBehavior {
    var maxHeight: CGFloat
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < maxHeight {
            target.rect = .zero
        }
    }
}


#Preview {
    ContentView()
}
