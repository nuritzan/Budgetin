//
//  HistoryTransactionsPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct HistoryTransactionsPage: View {
    @State private var isAddTransactionSheetPresented: Bool = false
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 28) {
                    Text("Transactions")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            Text("Friday, 12 Jun 2026")
                                .foregroundStyle(Color("PrimaryBlack"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            rowTransactions(category: "Subscription", description: "iCloud", amount: "-Rp15.000")
                            rowTransactions(category: "Transportation", description: "Online Taxi", amount: "-Rp18.000")
                            rowTransactions(category: "Transportation", description: "Commuter", amount: "-Rp6.000")
                            rowTransactions(category: "Meals", description: "Dinner", amount: "-Rp32.500")
                            rowTransactions(category: "Meals", description: "Lunch", amount: "-Rp30.000")
                        }
                        
                        VStack(spacing: 16) {
                            Text("Thursday, 11 Jun 2026")
                                .foregroundStyle(Color("PrimaryBlack"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            rowTransactions(category: "Shopping", description: "Skincare", amount: "-Rp80.000")
                            rowTransactions(category: "Household", description: "House Rent", amount: "-Rp1.000.000")
                            rowTransactions(category: "Entertainment", description: "Badminton", amount: "-Rp25.000")
                        }
                        
                        VStack(spacing: 16) {
                            Text("Wednesday, 10 Jun 2026")
                                .foregroundStyle(Color("PrimaryBlack"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            rowTransactions(category: "Health", description: "BPJS", amount: "Rp100.000")
                            rowTransactions(category: "Other", description: "Admin Fees", amount: "Rp1.000")
                            rowTransactions(category: "Meals", description: "Dinner", amount: "Rp40.000")
                            
                        }
                        
                        VStack(spacing: 16) {
                            Text("Tuesday, 9 Jun 2026")
                                .foregroundStyle(Color("PrimaryBlack"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            rowTransactions(category: "Subscription", description: "Netflix", amount: "-65.000")
                            rowTransactions(category: "Meals", description: "Dinner", amount: "-35.000")
                            rowTransactions(category: "Transportation", description: "Commuter", amount: "-Rp3.000")
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
    }
}
