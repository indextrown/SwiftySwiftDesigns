//
//  RectKey.swift
//  DarkModeAnimation
//
//  Created by 김동현 on 1/8/25.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue() 
    }
}
