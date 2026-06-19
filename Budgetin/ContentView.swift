//
//  ContentView.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 18/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: TabKey = .summary
    
    var body: some View {
            TabView(selection: $selection) {
                Tab ("Summary", systemImage: "chart.bar.xaxis", value: TabKey.summary) {
                    NavigationStack {
                        SummaryPage()
                    }
                }
                
                Tab ("Profile", systemImage: "person.circle.fill", value: TabKey.profile) {
                    ProfilePage()
                }
                
                Tab (value: TabKey.search, role: .search) {
                    SearchPage()
                }
            }
            .tint(Color("PrimaryGreen"))
    }
}

private enum TabKey: Hashable {
    case summary, profile, search
}

#Preview {
    ContentView()
}
