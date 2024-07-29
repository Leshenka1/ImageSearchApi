//
//  ContentView.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    @State private var searchQuery = ""
    @State private var showingSettings = false
    @EnvironmentObject var settings: ImageSearchSettings
    
    var body: some View {
        NavigationView {
            VStack {
                header
                SearchBar(searchQuery: $searchQuery, onSearch: searchImages)
                if let errorMessage = viewModel.errorMessage {
                    errorText(errorMessage)
                }
                if viewModel.noResults {
                    noResultsText
                }
                ImageGrid(images: viewModel.images)
            }
            .background(Color.gray.opacity(0.2))
        }
    }
    
    private var header: some View {
        HStack {
            Text("Image Search")
                .font(.system(size: 36, weight: .bold))
            Spacer()
            Button(action: {
                showingSettings = true
            }) {
                Image(systemName: "gear")
                    .font(.title)
            }
            .sheet(isPresented: $showingSettings) {
                Settings()
            }
        }
        .padding()
    }
    
    private func searchImages() {
        Task {
            await viewModel.searchImages(query: searchQuery, numberOfImages: settings.numberOfImages)
        }
    }
    
    private func errorText(_ message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .padding()
    }
    
    private var noResultsText: some View {
        Text("No results found for your request")
            .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(ImageSearchSettings())
}
