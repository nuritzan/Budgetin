//
//  StatisticsFunction.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 19/06/26.
//

import SwiftUI
import Charts

struct StatisticsFunction: View {
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                DatePicker(
                    "Start Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
                
                Divider()
                
                DatePicker(
                    "End Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
            }
            .padding(16)
            .glassEffect(in: .rect(cornerRadius: 20))
            .shadow(radius: 1)
            
            HStack(spacing: 24) {
                donutChart
                legendList
            }
        }
        .frame(width: 360)
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

func dateRow(label: String, dateString: String) -> some View {
    HStack {
        Text(label)
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(Color("PrimaryBlack"))
        
        Spacer()
        
        Text(dateString)
            .font(.callout)
            .foregroundStyle(Color("PrimaryBlack"))
        
        Image(systemName: "chevron.right")
            .font(Font.callout)
            .foregroundStyle(Color("PrimaryGray"))
    }
}

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

#Preview {
    StatisticsFunction()
}
