//
//  MainCard.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct MainCard: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Monthly Budget")
                    .font(Font.title3)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Rp3.500.000")
                    .font(Font.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("PrimaryBlack"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ProgressView(value: 596500, total: 3500000)
                .scaleEffect(y: 2)
                .tint(Color("PrimaryGreen"))
            
            Text("Rp596.500 remaining")
                .font(Font.title2.weight(.semibold))
                .foregroundStyle(Color("PrimaryBlack"))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .frame(width: 360)
        .glassEffect(in: .rect(cornerRadius: 24))
    }
}

#Preview {
    MainCard()
}
