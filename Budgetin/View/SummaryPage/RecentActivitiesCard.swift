//
//  RecentActivityCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

func getCategoryStyle(category: String) -> (icon: String, iconColor: Color, bgColor: Color) {
    switch category {
    case "Meals":
        return ("fork.knife", Color("Meals"), Color("MealsBackground"))
    case "Household":
        return ("house.fill", Color("Household"), Color("HouseholdBackground"))
    case "Transportation":
        return ("car.fill", Color("Transport"), Color("TransportBackground"))
    case "Subscription":
        return ("creditcard.fill", Color("Subscription"), Color("SubscriptionBackground"))
    case "Shopping":
        return ("cart.fill", Color("Shopping"), Color("ShoppingBackground"))
    case "Entertainment":
        return ("gamecontroller.fill", Color("Entertainment"), Color("EntertainmentBackground"))
    case "Health":
        return ("heart.fill", Color("Health"), Color("HealthBackground"))
    default:
        return ("ellipsis.circle.fill", Color("Other"), Color("OtherBackground"))
    }
}

@ViewBuilder
func rowTransactions(category: String, description: String, amount: String) -> some View {
    let style = getCategoryStyle(category: category)
    
    HStack{
        HStack(spacing: 10) {
            Image(systemName: style.icon)
                .font(Font.footnote)
                .foregroundStyle(style.iconColor)
                .frame(width: 30, height: 30)
                .background(style.bgColor)
                .clipShape(.circle)
            
            VStack (alignment: .leading) {
                Text(category)
                    .font(Font.callout)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .lineLimit(1)
                
                Text(description)
                    .font(Font.caption2)
                    .foregroundStyle(Color("PrimaryBlack"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(amount)
            .font(Font.callout)
            .foregroundStyle(Color("PrimaryRed"))
    }
}

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
                            .font(Font.subheadline)
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
            .padding(16)
            .frame(maxWidth: .infinity)
            .glassEffect(in: .rect(cornerRadius: 24))
            .shadow(radius: 1)
            
            NavigationLink{
                StatisticsPage()
            } label: {
                HStack {
                    Text("Show All Statistics")
                        .font(Font.callout)
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.right")
                        .font(Font.callout)
                        .foregroundStyle(Color("PrimaryGray"))
                        .frame(alignment: .trailing)
                }
                .padding(16)
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
