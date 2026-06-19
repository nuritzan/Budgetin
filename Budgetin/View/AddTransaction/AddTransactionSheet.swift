//
//  AddTransactionSheet.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct AddTransactionSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var amount: String = ""
    @State private var selectedCategory: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @State private var transactionDescription: String = ""
    
    let categories = ["Meals", "Household", "Transport", "Shopping", "Subscription", "Health", "Entertainment", "Other"]
    
    private func formatRupiah(_ value: String) -> String {
        let cleanNumber = value.filter{ "0123456789".contains($0) }
        
        guard let intValue = Int(cleanNumber) else { return "" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        
        return formatter.string(from: NSNumber(value: intValue)) ?? ""
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
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(Font.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryWhite"))
                            .frame(width: 34, height: 34)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("PrimaryGreen"))
                    .buttonBorderShape(.circle)
                }
                .frame(width: 380)
                
                VStack(spacing: 8) {
                    Text("Amount")
                        .font(Font.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("PrimaryBlack"))
                    
                    HStack(spacing: 2) {
                        Text("Rp")
                            .font(Font.largeTitle.bold())
                            .foregroundStyle(Color("PrimaryBlack"))
                        
                        TextField("0", text: $amount)
                            .font(Font.largeTitle.bold())
                            .foregroundStyle(Color("PrimaryBlack"))
                            .keyboardType(.numberPad)
                            .fixedSize()
                            .onChange(of: amount) { oldValue, newValue in
                            amount = formatRupiah(newValue)}
                    }
                }
                
                VStack(spacing: 8){
                    HStack{
                        Text("Category")
                            .font(Font.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("Select Category", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .tint(Color("PrimaryBlack"))
                    }
                    .frame(height: 30)
                    
                    Divider()
                    
                    DatePicker(
                        "Date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .font(Font.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .tint(Color("PrimaryGreen"))
                    .frame(height: 30)
                    
                    Divider()
                    
                    DatePicker(
                        "Time",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .font(Font.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .tint(Color("PrimaryGreen"))
                    .frame(height: 30)
                    
                    Divider()
                    
                    TextField("Description", text: $transactionDescription)
                        .font(Font.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                }
                .padding(20)
                .frame(width: 360)
                .glassEffect(in: .rect(cornerRadius: 24))
                .shadow(radius: 1)
                
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
