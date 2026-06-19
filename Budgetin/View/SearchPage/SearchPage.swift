//
//  SearchPage.swift
//  Budgetin
//
//  Created by Muhammad Muthi' Nuritzan on 19/06/26.
//

import SwiftUI

struct SearchPage: View {
    @State private var searchText: String = ""
    
    
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return []
        }
        return [].filter{$0.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                List(filteredItems, id: \.self){ item in
                    Text(item)
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
