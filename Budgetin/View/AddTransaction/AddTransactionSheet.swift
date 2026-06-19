//
//  AddTransactionSheet.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct AddTransactionSheet: View {
    @Environment(\.dismiss) var dismiss
    
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
                    
                    Text("Rp35.000")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                }
                
                VStack(spacing: 8){
                    HStack{
                        Text("Category")
                            .font(Font.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            HStack(spacing: 10) {
                                Image(systemName: "fork.knife")
                                    .font(Font.footnote)
                                    .foregroundStyle(Color("Meals"))
                                    .frame(width: 30, height: 30)
                                    .background(Color("MealsBackground"))
                                    .clipShape(.circle)
                                Text("Meals")
                                    .font(Font.callout)
                                    .foregroundStyle(Color("PrimaryBlack"))
                            }
                            Image(systemName: "chevron.right")
                                .font(Font.callout)
                                .foregroundStyle(Color("PrimaryGray"))
                        }
                    }
                    .frame(height: 30)
                    
                    Divider()
                    
                    HStack{
                        Text("Date")
                            .font(Font.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            Text("12 Jun 2026")
                                .font(Font.callout)
                                .foregroundStyle(Color("PrimaryBlack"))
                        }
                        Image(systemName: "chevron.right")
                            .font(Font.callout)
                            .foregroundStyle(Color("PrimaryGray"))
                    }
                    .frame(height: 30)
                    
                    Divider()
                    
                    HStack{
                        Text("Time")
                            .font(Font.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("PrimaryBlack"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            Text("09:41 WIB")
                                .font(Font.callout)
                                .foregroundStyle(Color("PrimaryBlack"))
                        }
                        Image(systemName: "chevron.right")
                            .font(Font.callout)
                            .foregroundStyle(Color("PrimaryGray"))
                    }
                    .frame(height: 30)
                    
                    Divider()
                    
                    Text("Description")
                        .font(Font.callout)
                        .foregroundStyle(Color("PrimaryGray"))
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                }
                .padding(20)
                .frame(width: 360)
                .glassEffect(in: .rect(cornerRadius: 24))
                .shadow(radius: 1)
                
                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    AddTransactionSheet()
}
