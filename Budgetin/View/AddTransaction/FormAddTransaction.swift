//
//  FormAddTransaction.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 24/06/26.
//

import SwiftUI

struct FormAddTransaction: View {
    @Binding var amount: String
    @Binding var selectedCategory: String
    @Binding var selectedDate: Date
    @Binding var selectedTime: Date
    @Binding var transactionDescription: String
    
    let categories = ["Meals", "Household", "Transportation", "Shopping", "Subscription", "Health", "Entertainment", "Other"]
    
    var body: some View {
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
    }
}

#Preview {
    FormAddTransaction(
        amount: .constant(""),
        selectedCategory: .constant(""),
        selectedDate: .constant(Date()),
        selectedTime: .constant(Date()),
        transactionDescription: .constant(""))
}
