//
//  SetupBudgetPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 20/06/26.
//

import SwiftUI

struct SetupBudgetPage: View {
    @State private var monthlyBudget: Double = 0
    @State private var budgetText: String = "0"
    @State private var isContinue: Bool = false
    @State private var isFormattingBudgetText: Bool = false
    @FocusState private var isBudgetTextFocused: Bool
    
    var body: some View {
        ZStack {
            if isContinue {
                ContentView()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            } else {
                setupBudgetContent
                    .transition(.move(edge: .leading))
                    .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: isContinue)
    }
    
    private var setupBudgetContent: some View {
        ZStack {
            BackgroundColor()
            
            VStack(spacing: 100) {
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Set your monthly budget")
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.primaryGreen)
                        .multilineTextAlignment(.center)
                    
                    Text("This helps Budgetin track your spending")
                        .font(.subheadline)
                        .foregroundStyle(.primaryGreen)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("Rp")
                            .font(.largeTitle.weight(.medium))
                            .foregroundStyle(.primaryGreen)
                        
                        TextField("0", text: $budgetText)
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.primaryGreen)
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
                            budgetText = formatRupiah(String(Int(newValue)))
                        }
                    
                    HStack {
                        Text("Rp0").font(.caption).foregroundStyle(.primaryGray)
                        Spacer()
                        Text("Rp10.000.000").font(.caption).foregroundStyle(.primaryGray)
                    }
                    .padding(.bottom)
                    
                    Text("You can always change this later in your profile")
                        .font(.footnote)
                        .foregroundStyle(.primaryGray)
                }
                .frame(width: 320)
                
                Spacer()
                
                Button {
                    updateBudgetFromText()
                    isContinue = true
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundStyle(.primaryWhite)
                        .frame(width: 300, height: 35)
                }
                .buttonStyle(.glassProminent)
                .tint(Color("PrimaryGreen"))
            }
            .frame(maxWidth: .infinity)
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
        let formattedValue = digits.isEmpty ? "" : formatRupiah(String(Int(numericValue)))
        
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
        budgetText = formatRupiah(String(Int(clampedValue)))
    }
}

#Preview {
    SetupBudgetPage()
}
