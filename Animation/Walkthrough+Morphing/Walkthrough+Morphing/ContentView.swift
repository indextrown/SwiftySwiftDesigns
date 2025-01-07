//
//  ContentView.swift
//  Walkthrough+Morphing
//
//  Created by 김동현 on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        IntroView()
            .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
