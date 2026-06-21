//
//  StatisticsFunction.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 19/06/26.
//

import SwiftUI
import Charts

struct ChartCard: View {
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 8) {
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
                
                Divider()
                
                DatePicker(
                    "End Date",
                    selection: $endDate,
                    displayedComponents: .date
                )
                .fontWeight(.medium)
                .foregroundStyle(Color("PrimaryBlack"))
                .tint(Color("PrimaryGreen"))
                .frame(height: 30)
            }
            .padding(20)
            .glassEffect(in: .rect(cornerRadius: 20))
//            .shadow(radius: 1)
            
            HStack(spacing: 24) {
                donutChart
                legendList
            }
        }
        .frame(width: 360)
    }
}

#Preview {
    ChartCard()
}
