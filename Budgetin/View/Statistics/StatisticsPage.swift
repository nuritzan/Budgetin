//
//  StatisticsPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

struct CategorySummary: Identifiable, Equatable {
    var id: String { category }
    let category: String
    let amount: Int
    let percentage: Double
    let color: Color
}

struct StatisticsPage: View {
    @Query private var transactions: [DataTransaction]
    @State private var startDate: Date = {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        return Calendar.current.date(from: components) ?? Date()
    }()
    @State private var endDate: Date = Date()
    
    private var categorySummaries: [CategorySummary] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        // Set end date ke jam 23:59:59 agar mencakup transaksi di hari terakhir
        let end = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
        
        // Filter transaksi sesuai tanggal
        let filtered = transactions.filter { $0.dateTime >= start && $0.dateTime <= end }
        
        // Hitung total pengeluaran di rentang ini
        let total = filtered.reduce(0) { $0 + $1.amount }
        guard total > 0 else { return [] }
        
        // Kelompokkan berdasarkan kategori
        let grouped = Dictionary(grouping: filtered, by: { $0.category })
        
        // Buat ringkasannya
        var summaries = grouped.map { (category, txs) in
            let categoryTotal = txs.reduce(0) { $0 + $1.amount }
            let percentage = (Double(categoryTotal) / Double(total)) * 100
            let style = getCategoryStyle(category: category)
            
            return CategorySummary(
                category: category,
                amount: categoryTotal,
                percentage: percentage,
                color: style.iconColor
            )
        }
        
        // Urutkan dari pengeluaran terbesar
        summaries.sort { $0.amount > $1.amount }
        return summaries
    }
    
    private var totalExpense: Int {
        categorySummaries.reduce(0) { $0 + $1.amount }
    }
    
    
    var body: some View {
        ZStack {
            BackgroundColor()
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Statistics")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ChartCard(
                        startDate: $startDate,
                        endDate: $endDate,
                        summaries: categorySummaries,
                        totalExpense: totalExpense
                    )
                    
                    CategoryCard(summaries: categorySummaries)
                }
                .frame(maxWidth: 360)
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

#Preview {
    StatisticsPage()
        .modelContainer(SampleData.container)
}
