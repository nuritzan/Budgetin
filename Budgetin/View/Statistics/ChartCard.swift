//
//  StatisticsFunction.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 19/06/26.
//

import SwiftUI
import Charts

struct DonutChart: View {
    
    var summaries: [CategorySummary]
    var totalExpense: Int
    
    var body: some View {
        HStack(spacing: 16) {
            // Donut Chart Dinamis
            Chart(summaries) { item in
                SectorMark(
                    angle: .value("Percentage", item.percentage),
                    innerRadius: .ratio(0.65),
                    angularInset: 0.5
                )
                .foregroundStyle(item.color)
            }
            .frame(width: 180, height: 180)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: summaries)
            .chartBackground { proxy in
                VStack {
                    Text("Total Expense")
                        .font(Font.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("PrimaryBlack"))
                    
                    // Menyesuaikan ukuran font jika angkanya sangat besar
                    Text("Rp\(formatRupiah(String(totalExpense)))")
                        .font(.body.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                }
            }
            
            // Legend Dinamis
            VStack(alignment: .leading, spacing: 8){
                ForEach(summaries) { item in
                    HStack(spacing: 8) {
                        Rectangle()
                            .fill(item.color)
                            .frame(width: 12, height: 12)
                            .cornerRadius(2)
                        
                        Text(item.category)
                            .font(Font.caption2)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Text(String(format: "%.1f%%", item.percentage))
                            .font(Font.caption2)
                            .foregroundStyle(Color("PrimaryBlack"))
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ChartCard: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    var summaries: [CategorySummary]
    var totalExpense: Int
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
                
                Divider()
                
                DatePicker(
                    "End Date",
                    selection: $endDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
            }
            .padding(20)
            .glassEffect(in: .rect(cornerRadius: 20))
            
            if summaries.isEmpty {
                Text("")
            } else {
                DonutChart(
                    summaries: summaries,
                    totalExpense: totalExpense
                )
            }
        }
        .frame(width: 360)
    }
}

#Preview {
    ChartCard(
        startDate: .constant(Date()),
        endDate: .constant(Date()),
        summaries: [
            CategorySummary(category: "Meals", amount: 1500000, percentage: 59, color: Color("Meals")),
            CategorySummary(category: "Transportation", amount: 550000, percentage: 21.6, color: Color("Transport")),
            CategorySummary(category: "Shopping", amount: 490000, percentage: 19.4, color: Color("Shopping"))
        ],
        totalExpense: 2540000
    )
}
