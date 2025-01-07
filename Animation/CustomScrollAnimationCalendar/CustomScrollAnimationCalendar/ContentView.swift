//
//  ContentView.swift
//  CustomScrollAnimationCalendar
//
//  Created by 김동현 on 1/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safearea = $0.safeAreaInsets
            
            HomeView(safearea: safearea)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
