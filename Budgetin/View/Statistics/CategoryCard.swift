//
//  CategoryCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct CategoryCard: View {
    var body: some View {
        VStack(spacing: 20) {
            rowCategories(category: "Meals", amount: "-Rp1.509.500")
            rowCategories(category: "Household", amount: "-Rp1.000.000")
            rowCategories(category: "Transportation", amount: "-Rp319.500")
            rowCategories(category: "Shopping", amount: "-Rp232.000")
            rowCategories(category: "Subscription", amount: "-Rp113.000")
            rowCategories(category: "Health", amount: "-Rp100.000")
            rowCategories(category: "Entertainment", amount: "-Rp65.000")
            rowCategories(category: "Other", amount: "-Rp15.500")
        }
        .frame(width: 340)
    }
}

#Preview {
    CategoryCard()
}
