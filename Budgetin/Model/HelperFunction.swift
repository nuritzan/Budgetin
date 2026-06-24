//
//  HelperFunction.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 20/06/26.
//

import SwiftUI
import Charts

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

func formatRupiah(_ value: String) -> String {
    let cleanNumber = value.filter { $0.isNumber }
    
    guard let intValue = Int(cleanNumber) else { return "" }
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.decimalSeparator = ","
    
    return formatter.string(from: NSNumber(value: intValue)) ?? ""
}

@ViewBuilder
func rowCategories(category: String, amount: String) -> some View {
    let style = getCategoryStyle(category: category)
    
    HStack{
        HStack(spacing: 10) {
            Image(systemName: style.icon)
                .font(Font.footnote)
                .foregroundStyle(style.iconColor)
                .frame(width: 30, height: 30)
                .background(style.bgColor)
                .clipShape(.circle)
            
            Text(category)
                .font(Font.callout)
                .foregroundStyle(Color("PrimaryBlack"))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(amount)
            .font(Font.callout)
            .foregroundStyle(Color("PrimaryRed"))
    }
}

@ViewBuilder
func rowTransactions(category: String, description: String, amount: String) -> some View {
    let style = getCategoryStyle(category: category)
    
    HStack{
        HStack(spacing: 10) {
            Image(systemName: style.icon)
                .foregroundStyle(style.iconColor)
                .frame(width: 35, height: 35)
                .background(style.bgColor)
                .clipShape(.circle)
            
            VStack (alignment: .leading) {
                Text(category)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .lineLimit(1)
                
                Text(description)
                    .font(Font.caption2)
                    .foregroundStyle(Color("PrimaryBlack"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(amount)
            .foregroundStyle(Color("PrimaryRed"))
    }
}

struct ExpenseData: Identifiable {
    let id = UUID()
    let category: String
    let percentage: Double
    let color: Color
}

let expenses: [ExpenseData] = [
    ExpenseData(category: "Meals", percentage: 44.9, color: Color("Meals")),
    ExpenseData(category: "Household", percentage: 29.8, color: Color("Household")),
    ExpenseData(category: "Transportation", percentage: 9.6, color: Color("Transport")),
    ExpenseData(category: "Shopping", percentage: 6.9, color: Color("Shopping")),
    ExpenseData(category: "Subscription", percentage: 3.5, color: Color("Subscription")),
    ExpenseData(category: "Health", percentage: 3.0, color: Color("Health")),
    ExpenseData(category: "Entertainment", percentage: 1.9, color: Color("Entertainment")),
    ExpenseData(category: "Other", percentage: 0.4, color: Color("Other"))
]

var donutChart: some View {
    Chart(expenses) { item in
        SectorMark(
            angle: .value("Percentage", item.percentage),
            innerRadius: .ratio(0.65),
            angularInset: 0.5
        )
        .foregroundStyle(item.color)
    }
    .frame(width: 180, height: 180)
    
    .chartBackground{ proxy in
        VStack {
            Text("Total Expense")
                .font(Font.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color("PrimaryBlack"))
            Text("Rp3.354.500")
                .font(.headline.bold())
                .foregroundStyle(Color("PrimaryBlack"))
        }
    }
}

var legendList: some View {
    VStack{
        ForEach(expenses) { item in
            HStack(spacing: 8) {
                Rectangle()
                    .fill(item.color)
                    .frame(width: 12, height: 12)
                    .cornerRadius(2)
                
                Text(item.category)
                    .font(Font.caption2)
                    .foregroundStyle(Color("PrimaryBlack"))
                
                Spacer()
                
                Text(String(format: "%.1f%%", item.percentage))
                    .font(Font.caption2)
                    .foregroundStyle(Color("PrimaryBlack"))
            }
        }
    }
}
