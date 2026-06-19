//
//  StatisticsPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct StatisticsPage: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    Text("Statistics")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color("PrimaryBlack"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    StatisticsFunction()
                    
                    CategoryCard()
                }
                .frame(maxWidth: 360)
                .frame(maxWidth: .infinity)
                .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackgroundColor").ignoresSafeArea())
    }
}

#Preview {
    StatisticsPage()
}
