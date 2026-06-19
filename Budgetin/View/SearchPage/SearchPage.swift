//
//  SearchPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 19/06/26.
//

import SwiftUI

@ViewBuilder
func rowSearch(category: String) -> some View {
    let style = getCategoryStyle(category: category)
    
    HStack{
        HStack(spacing: 10) {
            Image(systemName: style.icon)
                .font(Font.subheadline)
                .foregroundStyle(style.iconColor)
                .frame(width: 35, height: 35)
                .background(style.bgColor)
                .clipShape(.circle)
            
            Text(category)
                .foregroundStyle(Color("PrimaryBlack"))
                .lineLimit(1)
        }
    }
}

struct SearchPage: View {
    @State private var searchText: String = ""
    
    private let recommendations = [
        "Meals",
        "Household",
        "Transportation",
        "Shopping",
        "Subscription",
        "Health",
        "Entertainment",
        "Other"
    ]
    
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return recommendations
        }
        return recommendations.filter{ $0.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                List(filteredItems, id: \.self) { item in
                    rowSearch(category: item)
                        .listRowBackground(Color.clear)
                }
                .navigationTitle("Search")
                .scrollContentBackground(.hidden)
            }
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    SearchPage()
}
