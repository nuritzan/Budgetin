//
//  EditBudgetPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 21/06/26.
//

import SwiftUI

struct EditBudgetPage: View {
    @State private var monthlyBudget: Double = 0
    @State private var budgetText: String = "0"
    @State private var isFormattingBudgetText: Bool = false
    @FocusState private var isBudgetTextFocused: Bool
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
                            
                            TextField("0", text: $budgetText)
                                .font(.largeTitle.weight(.semibold))
                                .foregroundStyle(.primaryBlack)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .frame(width: 220)
                                .focused($isBudgetTextFocused)
                                .onSubmit {
                                    updateBudgetFromText()
                                }
                                .onChange(of: budgetText) { _, newValue in
                                    formatBudgetText(newValue)
                                }
                                .onChange(of: isBudgetTextFocused) { _, isFocused in
                                    if !isFocused {
                                        updateBudgetFromText()
                                    }
                                }
                        }
                        
                        Slider(value: $monthlyBudget, in: 0...10_000_000, step: 50_000)
                            .tint(Color("PrimaryGreen"))
                            .onChange(of: monthlyBudget) { _, newValue in
                                budgetText = formatRupiah(newValue)
                            }
                        
                        HStack {
                            Text("Rp0").font(.caption).foregroundStyle(.primaryGray)
                            Spacer()
                            Text("Rp10.000.000").font(.caption).foregroundStyle(.primaryGray)
                        }
                    }
                    
                    Button{
                        updateBudgetFromText()
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    updateBudgetFromText()
                    isBudgetTextFocused = false
                }
            }
        }
    }
    
    private func formatBudgetText(_ value: String) {
        guard !isFormattingBudgetText else { return }
        
        let digits = value.filter { $0.isNumber }
        let numericValue = min(Double(digits) ?? 0, 10_000_000)
        let formattedValue = digits.isEmpty ? "" : formatRupiah(numericValue)
        
        isFormattingBudgetText = true
        budgetText = formattedValue
        monthlyBudget = numericValue
        isFormattingBudgetText = false
    }
    
    private func updateBudgetFromText() {
        let rawValue = budgetText
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
        
        guard let value = Double(rawValue) else {
            monthlyBudget = 0
            budgetText = "0"
            return
        }
        
        let clampedValue = min(max(value, 0), 10_000_000)
        monthlyBudget = clampedValue
        budgetText = formatRupiah(clampedValue)
    }
}

#Preview {
    EditBudgetPage()
}
