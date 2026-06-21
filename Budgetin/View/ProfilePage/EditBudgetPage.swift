//
//  EditBudgetPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 21/06/26.
//

import SwiftUI

struct EditBudgetPage: View {
    @State private var monthlyBudget: Double = 1_000_000
    @State private var budgetText: String = "1.000.000"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            VStack{
                Text("Monthly Budget")
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack(spacing: 64) {
                    VStack {
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text("Rp")
                                .font(.largeTitle.weight(.medium))
                                .foregroundStyle(.primaryBlack)
                            Text(monthlyBudget, format: .number)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primaryBlack)
                        }
                        
                        Slider(value: $monthlyBudget, in: 1000_000...10_000_000, step: 50_000)
                            .tint(Color("PrimaryGreen"))
                            .onChange(of: monthlyBudget) { _, newValue in
                                budgetText = formatRupiah(newValue)
                            }
                        
                        HStack {
                            Text("Rp1.000.000").font(.caption).foregroundStyle(.primaryGray)
                            Spacer()
                            Text("Rp10.000.000").font(.caption).foregroundStyle(.primaryGray)
                        }
                    }
                    
                    
                    Button{
                        dismiss()
                    } label: {
                        Text("Save Changes")
                            .fontWeight(.semibold)
                            .foregroundStyle(.primaryWhite)
                            .padding(.horizontal)
                            .frame(height: 35)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("PrimaryGreen"))
                }
                .frame(width: 340)
                
                Spacer()
            }
            .frame(width: 360)
        }
    }
}

#Preview {
    EditBudgetPage()
}
