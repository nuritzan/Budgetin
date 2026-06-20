//
//  SetupBudgetPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 20/06/26.
//

import SwiftUI

struct SetupBudgetPage: View {
    @State private var monthlyBudget: Double = 1_000_000
    @State private var budgetText: String = "1.000.000"
    @State private var isContinue: Bool = false
    
    var body: some View {
        ZStack {
            if isContinue {
                ContentView()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            } else {
                setupBudgetContent
                    .transition(.move(edge: .leading))
                    .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: isContinue)
    }
    
    private var setupBudgetContent: some View {
        ZStack {
            BackgroundColor()
            
            VStack(spacing: 100) {
                Spacer()
                
                VStack(spacing: 6) {
                    Text("Set your monthly budget")
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.primaryGreen)
                        .multilineTextAlignment(.center)
                    
                    Text("This helps Budgetin track your spending")
                        .font(.subheadline)
                        .foregroundStyle(.primaryGreen)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 16) {
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        Text("Rp")
                            .font(.largeTitle.weight(.medium))
                            .foregroundStyle(.primaryGreen)
                        Text(monthlyBudget, format: .number)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primaryGreen)
                    }
                    
                    // Mode 1: Slider
                    Slider(value: $monthlyBudget, in: 1000_000...10_000_000, step: 50_000)
                        .tint(Color("PrimaryGreen"))
                        .onChange(of: monthlyBudget) { _, newValue in
                            budgetText = formatRupiah(newValue)
                        }
                    
                    HStack {
                        Text("Rp1.000.000").font(.caption).foregroundStyle(.primaryGray)
                        Spacer()
                        Text("Rp10.000.000").font(.caption).foregroundStyle(.primaryGray)
                    }
                    .padding(.bottom)
                    
                    Text("You can always change this later in your profile")
                        .font(.footnote)
                        .foregroundStyle(.primaryGray)
                }
                .frame(width: 320)
                
                
                Spacer()
                
                Button {
                    isContinue = true
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundStyle(.primaryWhite)
                        .frame(width: 300, height: 35)
                }
                .buttonStyle(.glassProminent)
                .tint(Color("PrimaryGreen"))
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func formatRupiah(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
}

#Preview {
    SetupBudgetPage()
}
