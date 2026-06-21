//
//  ContentAvailableSoon.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 21/06/26.
//

import SwiftUI

struct ContentAvailableSoon: View {
    var body: some View {
        ZStack{BackgroundColor()
            VStack{
                Text("This feature will be available soon.")
                    .font(Font.title.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primaryBlack)
            }
            .frame(width: 360)
        }
    }
}

#Preview {
    ContentAvailableSoon()
}
