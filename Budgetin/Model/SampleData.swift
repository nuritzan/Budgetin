//
//  SampleData.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 24/06/26.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: DataTransaction.self, configurations: config)
            
            let sampleData: [DataTransaction] = [
                DataTransaction(amount: 45000, category: "Meals", dateTime: Date(), transactionDescription: "Dinner"),
                DataTransaction(amount: 18000, category: "Transportation", dateTime: Date(), transactionDescription: "Online Taxi"),
                DataTransaction(amount: 15000, category: "Subscription", dateTime: Date(), transactionDescription: "iCloud")
            ]
            
            for item in sampleData {
                container.mainContext.insert(item)
            }
            
            return container
        } catch {
            fatalError("Failed to load preview data: \(error.localizedDescription)")
        }
    } ()
}
