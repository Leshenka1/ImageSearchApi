//
//  ImageCell.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

import SwiftUI

struct ImageCell: View {
    @StateObject private var viewModel: ImageCellViewModel
    
    init(imageHit: ImageHit) {
        _viewModel = StateObject(wrappedValue: ImageCellViewModel(imageHit: imageHit))
    }
    
    var body: some View {
        VStack {
            if let uiImage = viewModel.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(viewModel.isVisible ? 1 : 0)
                    .scaleEffect(viewModel.isVisible ? 1 : 0.8)
                    .animation(.easeInOut(duration: 0.6), value: viewModel.isVisible)
                    .onAppear {
                        viewModel.isVisible = true
                    }
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Text("Failed to load")
            }

            Text(viewModel.imageHit.tags)
                .font(.caption)
                .lineLimit(1)
                .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.loadImage()
        }
    }
}
