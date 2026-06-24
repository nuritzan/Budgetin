//
//  AddTransactionSheet.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI
import SwiftData

struct AddTransactionSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var amount: String = ""
    @State private var selectedCategory: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var transactionDescription: String = ""
    
    private var isFormValid: Bool {
        let cleanAmount = amount.filter { $0.isNumber }
        let isAmountValid = (Int(cleanAmount) ?? 0) > 0
        
        let isCategoryValid = !selectedCategory.isEmpty
        
        let isDescriptionValid = !transactionDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return isAmountValid && isCategoryValid && isDescriptionValid
    }
    
    private func saveTransaction() {
        let cleanAmount = amount.filter { $0.isNumber }

        guard let amountValue = Int(cleanAmount), amountValue > 0 else {
            return
        }

        guard !selectedCategory.isEmpty else {
            return
        }

        let calendar = Calendar.current

        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)

        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute

        guard let combinedDateTime = calendar.date(from: combinedComponents) else {
            return
        }

        let transaction = DataTransaction(
            amount: amountValue,
            category: selectedCategory,
            dateTime: combinedDateTime,
            transactionDescription: transactionDescription.isEmpty ? "-" : transactionDescription
        )

        modelContext.insert(transaction)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to save transaction: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 32){
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(Font.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(width: 34, height: 34)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("CancelButton"))
                    .buttonBorderShape(.circle)
                    
                    Spacer()
                    
                    Text("Add Transaction")
                        .font(Font.headline)
                        .foregroundStyle(Color("PrimaryBlack"))
                    
                    Spacer()
                    
                    Button{
                        saveTransaction()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(Font.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(isFormValid ? Color("PrimaryWhite"): Color("PrimaryBlack"))
                            .frame(width: 34, height: 34)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(isFormValid ? Color("PrimaryGreen"): .gray)
                    .buttonBorderShape(.circle)
                    .disabled(!isFormValid)
                }
                .frame(width: 380)
                
                FormAddTransaction(
                    amount: $amount,
                    selectedCategory: $selectedCategory,
                    selectedDate: $selectedDate,
                    selectedTime: $selectedTime,
                    transactionDescription: $transactionDescription
                )
                
                Spacer()
            }
            .padding(.top, 20)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    AddTransactionSheet()
}
