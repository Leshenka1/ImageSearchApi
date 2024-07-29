//
//  SearchBar.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

import SwiftUI

struct SearchBar: View {
    @Binding var searchQuery: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search for images...", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: searchQuery) { oldValue, newValue in
                    if newValue.count > 100 {
                        searchQuery = String(newValue.prefix(100))
                    }
                }
            
            Button(action: {
                onSearch()
            }) {
                Text("Search")
                    .padding(.all, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.trailing)
        }
    }
}


