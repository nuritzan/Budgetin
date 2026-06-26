//
//  MainCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

struct MainCard: View {
    @Query private var settings: [UserSetting]
    @Query private var transactions: [DataTransaction]
    
    private var monthlyBudget: Double {
        settings.first?.monthlyBudget ?? 0
    }
    
    private var currentMonthTransactions: [DataTransaction] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let currentYear = calendar.component(.year, from: Date())
        
        return transactions.filter { transaction in
            let transMonth = calendar.component(.month, from: transaction.dateTime)
            let transYear = calendar.component(.year, from: transaction.dateTime)
            return transMonth == currentMonth && transYear == currentYear
        }
    }
    
    private var totalExpenses: Double {
        let total = currentMonthTransactions.reduce(0) { sum, transaction in
            sum + transaction.amount
        }
        return Double(total)
    }
    
    private var remainingBudget: Double {
        return monthlyBudget - totalExpenses
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Monthly Budget")
                    .font(Font.title3)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Rp\(formatRupiah(String(Int(monthlyBudget))))")
                    .font(Font.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ProgressView(value: max(remainingBudget, 0), total: monthlyBudget > 0 ? monthlyBudget : 1)
                .scaleEffect(y: 3)
                .tint(Color("PrimaryGreen"))
            
            let isMinus = remainingBudget < 0
            let absoluteRemaining = abs(remainingBudget)
            
            Text("\(isMinus ? "-" : "")Rp\(formatRupiah(String(Int(absoluteRemaining)))) remaining")
                .font(Font.title2.weight(.semibold))
                .foregroundStyle(isMinus ? Color("PrimaryRed"): Color("PrimaryBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .frame(width: 360)
        .glassEffect(in: .rect(cornerRadius: 24))
    }
}

#Preview {
    MainCard()
        .modelContainer(SampleData.container)
}
