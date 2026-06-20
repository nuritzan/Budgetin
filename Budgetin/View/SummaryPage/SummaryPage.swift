//
//  SummaryPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct SummaryPage: View {
    @State private var isAddTransactionSheetPresented: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundColor()
            
            VStack(spacing: 48) {
                HStack {
                    Text("Summary")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        isAddTransactionSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .font(Font.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryWhite"))
                            .frame(width: 29, height: 29)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color("PrimaryGreen"))
                    .buttonBorderShape(.circle)
                }
                .frame(width: 360)
                
                MainCard()
                
                RecentActivitiesCard()
                
                Spacer()
            }
            .padding(.top)
        }
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $isAddTransactionSheetPresented) {
            AddTransactionSheet()
        }
    }
}

#Preview {
    NavigationStack {
        SummaryPage()
    }
}
