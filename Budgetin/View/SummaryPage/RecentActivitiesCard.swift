//
//  RecentActivityCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct RecentActivitiesCard: View {
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
                
                rowTransactions(category: "Subscription", description: "iCloud", amount: "-Rp15.000")
                rowTransactions(category: "Transportation", description: "Online Taxi", amount: "-Rp18.000")
                rowTransactions(category: "Transportation", description: "Commuter", amount: "-Rp6.000")
                rowTransactions(category: "Meals", description: "Dinner", amount: "-Rp32.500")
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .glassEffect(in: .rect(cornerRadius: 24))
            .shadow(radius: 1)
            
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
                .shadow(radius: 1)
            }
            
            
        }
        .frame(width: 360)
    }
}

#Preview {
    RecentActivitiesCard()
}
