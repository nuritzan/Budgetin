//
//  ContentView.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                SummaryPage()
                    .tabItem{
                        Image(systemName: "chart.bar.xaxis")
                        Text("Summary")
                    }
                ProfilePage()
                    .tabItem{
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
            }
            .tint(Color("PrimaryGreen"))
        }
    }
}

#Preview {
    ContentView()
}
