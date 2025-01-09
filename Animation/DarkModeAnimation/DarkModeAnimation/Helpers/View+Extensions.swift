//
//  View+Extensions.swift
//  DarkModeAnimation
//
//  Created by 김동현 on 1/8/25.
//

import SwiftUI

// MARK: - CustomView Extensions
extension View {
    @ViewBuilder
    func rect(value: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { geometry in
                    let rect = geometry.frame(in: .global)
                    
                    Color.clear
                        .preference(key: RectKey.self, value: rect)
                        .onPreferenceChange(RectKey.self, perform: { rect in
                            value(rect)
                        })
                }
            }
    }
    
    @MainActor
    @ViewBuilder
    func createImages(toggleDarkMode: Bool, currentImage: Binding<UIImage?>, previousImage: Binding<UIImage?>, activateDarkMode: Binding<Bool>) -> some View {
         self
            .onChange(of: toggleDarkMode) { oldValue, newValue in
                Task {
                    if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow }) {
                        let imageView = UIImageView()
                        imageView.frame = window.frame
                        imageView.image = window.rootViewController?.view.Image(window.frame.size)
                        imageView.contentMode = .scaleAspectFit
                        window.addSubview(imageView)
                        
                        if let rootView = window.rootViewController?.view {
                            let frameSize = rootView.frame.size
                            
                            // MARK: - Creating Snapshots
                            activateDarkMode.wrappedValue = !newValue
                            previousImage.wrappedValue = rootView.Image(frameSize)
                            
                            // MARK: - New One with Updated Trait State
                            // try await Task.sleep(for: .seconds(0.01))
                            activateDarkMode.wrappedValue = newValue
                            
                            // MARK: - Giving some time to complete the transition
                            try await Task.sleep(for: .seconds(0.01))
                            currentImage.wrappedValue = rootView.Image(frameSize)
                            
                            // MARK: - Removing once all the snapshots has taken
                            try await Task.sleep(for: .seconds(0.01))
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
    }
}



// MARK: - Converting UIView to UIImage
extension UIView {
    func Image(_ size: CGSize) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
