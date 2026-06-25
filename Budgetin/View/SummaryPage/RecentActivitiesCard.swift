//
//  RecentActivityCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

struct RecentActivitiesCard: View {
    @Query(sort: \DataTransaction.dateTime, order: .reverse)
    private var transactions: [DataTransaction]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Recent Activities")
                .font(Font.headline)
                .foregroundStyle(Color("PrimaryBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                NavigationLink{
                    HistoryTransactionsPage()
                } label: {
                    HStack{
                        Text("Transactions")
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "chevron.right")
                            .font(Font.subheadline)
                            .foregroundStyle(Color("PrimaryGray"))
                            .frame(alignment: .trailing)
                    }
                }
                
                if transactions.isEmpty {
                    Text("No recent transactions yet.")
                        .foregroundStyle(.primaryBlack)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                } else {
                    ForEach(transactions.prefix(4)) { transaction in
                        rowTransactions(category: transaction.category, description: transaction.transactionDescription, amount: "-Rp\(formatRupiah(String(transaction.amount)))")
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .glassEffect(in: .rect(cornerRadius: 24))
            
            NavigationLink{
                StatisticsPage()
            } label: {
                HStack {
                    Text("Show All Statistics")
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .font(Font.callout)
                        .foregroundStyle(Color("PrimaryGray"))
                        .frame(alignment: .trailing)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .clipShape(.capsule)
                .glassEffect()
            }
            
            
        }
        .frame(width: 360)
    }
}

#Preview {
    RecentActivitiesCard()
        .modelContainer(SampleData.container)
}
