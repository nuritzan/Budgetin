//
//  EditBudgetPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 21/06/26.
//

import SwiftUI
import SwiftData

struct EditBudgetPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var settings: [UserSetting]
    @State private var editedBudget: Double = 0
    
    @State private var budgetText: String = ""
    @State private var isFormattingBudgetText: Bool = false
    @FocusState private var isBudgetTextFocused: Bool
    @Environment(\.dismiss) var dismiss
    @State private var showAlert: Bool = false
    
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
                        
                        Slider(value: $editedBudget, in: 0...10_000_000, step: 50_000)
                            .tint(Color("PrimaryGreen"))
                            .onChange(of: editedBudget) { _, newValue in
                                budgetText = formatRupiah(String(Int(newValue)))
                            }
                        
                        HStack {
                            Text("Rp0").font(.caption).foregroundStyle(.primaryGray)
                            Spacer()
                            Text("Rp10.000.000").font(.caption).foregroundStyle(.primaryGray)
                        }
                    }
                    
                    Button{
                        showAlert = true
                    } label: {
                        Text("Save Changes")
                            .fontWeight(.semibold)
                            .foregroundStyle(.primaryWhite)
                            .padding(.horizontal)
                            .frame(height: 35)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("PrimaryGreen"))
                    .disabled(editedBudget == 0)
                }
                .frame(width: 340)
                
                Spacer()
            }
            .frame(width: 360)
        }
        .alert("Save your chnges", isPresented: $showAlert) {
            Button("No", role: .cancel) {}
            Button("Yes") {
                updateBudgetFromText()
                if let setting = settings.first {

                        setting.monthlyBudget = editedBudget

                        do {
                            try modelContext.save()
                        } catch {
                            print(error)
                        }

                    }
                dismiss()
            }
        } message: {
            Text("Your monthly budget will be updated.")
        }
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    updateBudgetFromText()
//                    isBudgetTextFocused = false
//                }
//            }
//        }
        .onAppear{
            editedBudget = settings.first?.monthlyBudget ?? 0
            
            budgetText = formatRupiah(String(Int(editedBudget)))
        }
    }
    
    private func formatBudgetText(_ value: String) {
        guard !isFormattingBudgetText else { return }
        
        let digits = value.filter { $0.isNumber }
        let numericValue = min(Double(digits) ?? 0, 10_000_000)
        let formattedValue = digits.isEmpty ? "" : formatRupiah(String(Int(numericValue)))
        
        isFormattingBudgetText = true
        budgetText = formattedValue
        editedBudget = numericValue
        isFormattingBudgetText = false
    }
    
    private func updateBudgetFromText() {
        let rawValue = budgetText
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: "")
        
        guard let value = Double(rawValue) else {
            editedBudget = 0
            budgetText = "0"
            return
        }
        
        let clampedValue = min(max(value, 0), 10_000_000)
        editedBudget = clampedValue
        budgetText = formatRupiah(String(Int(clampedValue)))
    }
}

#Preview {
    EditBudgetPage()
}
