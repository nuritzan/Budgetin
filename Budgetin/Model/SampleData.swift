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
            let container = try ModelContainer(
                for:
                    DataTransaction.self,
                UserSetting.self
                ,
                configurations: config
            )
            
            let sampleData: [DataTransaction] = [
                DataTransaction(amount: 45000, category: "Meals", dateTime: Date(), transactionDescription: "Dinner"),
                DataTransaction(amount: 18000, category: "Transportation", dateTime: Date(), transactionDescription: "Online Taxi"),
                DataTransaction(amount: 15000, category: "Subscription", dateTime: Date(), transactionDescription: "iCloud"),
                DataTransaction(amount: 105000, category: "Health", dateTime: Date(), transactionDescription: "BPJS")
            ]
            
            for item in sampleData {
                container.mainContext.insert(item)
            }
            
            let setting = UserSetting(
                monthlyBudget: 3_500_00
            )
            
            container.mainContext.insert(setting)
            
            return container
        } catch {
            fatalError("Failed to load preview data: \(error.localizedDescription)")
        }
    } ()
}
