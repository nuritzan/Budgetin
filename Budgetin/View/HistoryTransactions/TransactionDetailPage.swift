//
//  TransactionDetailPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 29/06/26.
//

import SwiftUI
import SwiftData

struct TransactionDetailPage: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var transaction: DataTransaction
    
    @State private var amount: String
    @State private var selectedCategory: String
    @State private var selectedDate: Date
    @State private var selectedTime: Date
    @State private var transactionDescription: String
    
    @State private var showSaveAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    init(transaction: DataTransaction) {
        self.transaction = transaction
        _amount = State(initialValue: formatRupiah(String(transaction.amount)))
        _selectedCategory = State(initialValue: transaction.category)
        _selectedDate = State(initialValue: transaction.dateTime)
        _selectedTime = State(initialValue: transaction.dateTime)
        _transactionDescription = State(initialValue: transaction.transactionDescription)
    }
    
    private var isFormValid: Bool {
        let cleanAmount = amount.filter { $0.isNumber }
        let isAmountValid = (Int(cleanAmount) ?? 0) > 0
        let isCategoryValid = !selectedCategory.isEmpty
        let isDescriptionValid = !transactionDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isAmountValid && isCategoryValid && isDescriptionValid
    }
    
    private func updateTransaction() {
        let cleanAmount = amount.filter { $0.isNumber }
        guard let amountValue = Int(cleanAmount), amountValue > 0, !selectedCategory.isEmpty else { return }
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        guard let combinedDateTime = calendar.date(from: combinedComponents) else { return }
        
        // Memperbarui data yang sudah ada (tidak membuat baru)
        transaction.amount = amountValue
        transaction.category = selectedCategory
        transaction.dateTime = combinedDateTime
        transaction.transactionDescription = transactionDescription.isEmpty ? "-" : transactionDescription
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to update transaction: \(error.localizedDescription)")
        }
    }
    
    private func deleteTransaction() {
        modelContext.delete(transaction)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Failed to delete transaction: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ZStack{
            BackgroundColor()
            
            VStack(spacing: 32) {
                HStack {
                    Button {
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
                    
                    Text("Edit Transaction")
                        .font(Font.headline)
                        .foregroundStyle(Color("PrimaryBlack"))
                    
                    Spacer()
                    
                    Button {
                        updateTransaction()
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
                
                Button {
                    showDeleteAlert = true
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete")
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(height: 35)
                }
                .buttonStyle(.glassProminent)
                .tint(.red)
                
                Spacer()
            }
            .padding(.top, 20)

        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("Are you sure you want to delete this transaction?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
                .tint(.black)
            Button("Delete", role: .destructive) {
                deleteTransaction()
            }
        }
    }
}

#Preview {
    TransactionDetailPage(
        transaction: DataTransaction(
            amount: 75000,
            category: "Meals",
            dateTime: Date(),
            transactionDescription: "Lunch Zhangliang Malatang"
        )
    )
}
