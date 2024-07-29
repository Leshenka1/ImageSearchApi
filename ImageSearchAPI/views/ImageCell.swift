//
//  ImageCell.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

struct ImageCell: View {
    let imageHit: ImageHit
    @State private var imageData: Data?
    @State private var isLoading = true

    var body: some View {
        VStack {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if isLoading {
                ProgressView()
            } else {
                Text("Failed to load")
            }

            Text(imageHit.tags)
                .font(.caption)
                .lineLimit(1)
                .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = URL(string: imageHit.previewURL) else {
            isLoading = false
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url, timeout: 10)
                imageData = data
            } catch {
                print("Failed to load image: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
