//
//  CategoryCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct CategoryCard: View {
    var summaries: [CategorySummary]
    
    var body: some View {
        VStack(spacing: 20) {
            if summaries.isEmpty {
                Text("No data available")
            } else {
                ForEach(summaries) { item in
                    rowCategories(
                        category: item.category,
                        amount: "-Rp\(formatRupiah(String(item.amount)))")
                }
            }
        }
        .frame(width: 340)
    }
}

#Preview {
    CategoryCard(
        summaries: [
            CategorySummary(category: "Meals", amount: 1500000, percentage: 59, color: Color("Meals")),
            CategorySummary(category: "Transportation", amount: 550000, percentage: 21.6, color: Color("Transport")),
            CategorySummary(category: "Shopping", amount: 490000, percentage: 19.4, color: Color("Shopping"))
        ]
    )
}
