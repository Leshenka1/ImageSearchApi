//
//  ImageCellViewModel.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 30.07.24.
//

import SwiftUI

class ImageCellViewModel: ObservableObject {
    @Published var imageHit: ImageHit
    @Published var uiImage: UIImage?
    @Published var isLoading = true
    @Published var isVisible = false
    
    init(imageHit: ImageHit) {
        self.imageHit = imageHit
    }
    
    func loadImage() {
        guard let url = URL(string: imageHit.previewURL) else {
            isLoading = false
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url, timeout: 20)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                        self.isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } catch {
                print("Failed to load image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}
