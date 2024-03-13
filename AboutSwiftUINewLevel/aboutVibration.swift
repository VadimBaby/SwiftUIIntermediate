//
//  aboutVibration.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 23.04.2023.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct aboutVibration: View {
    var body: some View {
        VStack(spacing: 30){
            Button("success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("error") {
                HapticManager.instance.notification(type: .error)
            }
            Divider()
            Button("heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
            Button("light") {
                HapticManager.instance.impact(style: .light)
            }
            Button("medium") {
                HapticManager.instance.impact(style: .medium)
            }
            Button("rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            Button("soft") {
                HapticManager.instance.impact(style: .soft)
            }
        }
    }
}

struct aboutVibration_Previews: PreviewProvider {
    static var previews: some View {
        aboutVibration()
    }
}
