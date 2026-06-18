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
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 48) {
                HStack {
                    Text("Summary")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button{
                        isAddTransactionSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .font(Font.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color("PrimaryWhite"))
                            .frame(width: 44, height: 44)
                            .background(Color("PrimaryGreen"))
                            .clipShape(.circle)
                            .glassEffect()
                            .frame(alignment: .trailing)
                    }
                    .sheet(isPresented: $isAddTransactionSheetPresented) {
                        AddTransactionSheet()
                    }
                }
                .frame(width: 360)
                
                MainCard()
                
                RecentActivitiesCard()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SummaryPage()
}
