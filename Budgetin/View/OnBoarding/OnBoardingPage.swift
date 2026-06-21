//
//  OnBoardingPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 20/06/26.
//

import SwiftUI

struct OnBoardingPage: View {
    @State private var isGetStarted: Bool = false
    
    var body: some View {
        ZStack {
            if isGetStarted {
                SetupBudgetPage()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            } else {
                onboardingContent
                    .transition(.move(edge: .leading))
                    .zIndex(0)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: isGetStarted)
    }
    
    private var onboardingContent: some View {
        ZStack {
            BackgroundColor()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Budgetin")
                        .font(.system(size: 62))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("PrimaryGreen"))
                    
                    Text("Set your budget, spend with clarity")
                        .font(.system(size: 16))
                        .foregroundStyle(.primaryGreen)
                }
                
                Spacer()
                
                Button {
                    isGetStarted = true
                } label: {
                    Text("Get Started")
                        .fontWeight(.semibold)
                        .foregroundStyle(.primaryWhite)
                        .frame(width: 300, height: 35)
                }
                .buttonStyle(.glassProminent)
                .tint(.primaryGreen)
            }
        }
    }
}

#Preview {
    OnBoardingPage()
}
