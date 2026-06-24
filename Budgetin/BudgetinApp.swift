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
    var body: some Scene {
        WindowGroup {
            OnBoardingPage()
        }
        .modelContainer(for: DataTransaction.self)
    }
}
