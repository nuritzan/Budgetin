//
//  BudgetinApp.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

@main
struct BudgetinApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView()
            } else {
                OnBoardingPage()
            }
        }
        .modelContainer(for: [
            DataTransaction.self,
            UserSetting.self
        ])
    }
}
