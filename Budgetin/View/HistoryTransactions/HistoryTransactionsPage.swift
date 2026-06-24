//
//  HistoryTransactionsPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

struct HistoryTransactionsPage: View {
    @State private var isAddTransactionSheetPresented: Bool = false
    
    @Query(sort: \DataTransaction.dateTime, order: .reverse)
    private var transactions: [DataTransaction]
    
    private var transactionSections: [(date: Date, items: [DataTransaction])] {
        let groupedTransactions = Dictionary(grouping: transactions) { transaction in
            Calendar.current.startOfDay(for: transaction.dateTime)
        }

        return groupedTransactions
            .map { (date: $0.key, items: $0.value) }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            ScrollView {
                VStack(spacing: 28) {
                    Text("Transactions")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 24) {
                        ForEach(transactionSections, id: \.date) { section in
                            VStack(spacing: 16) {
                                Text(section.date.formatted(.dateTime.weekday(.wide).day().month(.abbreviated).year()))
                                    .foregroundStyle(Color("PrimaryBlack"))
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                ForEach(section.items) { transaction in
                                    rowTransactions(
                                        category: transaction.category,
                                        description: transaction.transactionDescription,
                                        amount: "-Rp\(formatRupiah(String(transaction.amount)))"
                                    )
                                }
                            }
                        }
                    }
                    .frame(width: 340)
                }
                .frame(width: 360)
                .padding(.top)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddTransactionSheetPresented = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color("PrimaryWhite"))
                }
                .buttonStyle(.glassProminent)
                .tint(Color("PrimaryGreen"))
                .buttonBorderShape(.circle)
            }
            
        }
        
        .sheet(isPresented: $isAddTransactionSheetPresented) {
            AddTransactionSheet()
        }
    }
}

#Preview {
    NavigationStack {
        HistoryTransactionsPage()
            .modelContainer(SampleData.container)
    }
}
