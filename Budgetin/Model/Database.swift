//
//  Database.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 24/06/26.
//

import Foundation
import SwiftData

@Model
class DataTransaction {
    var amount: Int
    var category: String
    var dateTime: Date
    var transactionDescription: String
    
    init(amount: Int, category: String, dateTime: Date, transactionDescription: String) {
        self.amount = amount
        self.category = category
        self.dateTime = dateTime
        self.transactionDescription = transactionDescription
    }
}
