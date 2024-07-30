//
//  ImageSearchViewModel.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import Foundation

class ImageSearchViewModel: ObservableObject {
    @Published var images: [ImageHit] = []
    @Published var errorMessage: String?
    @Published var noResults: Bool = false
    
    private let apiKey = "45126236-46eb5b18422a987b9ed11c107"
    
    func searchImages(query: String, numberOfImages: Int) async {
        await loadImages(query: query, numberOfImages: numberOfImages, clearPrevious: true)
    }
    
    func loadAdditionalImages(query: String, numberOfImages: Int) async {
        guard numberOfImages > images.count else { return }
        await loadImages(query: query, numberOfImages: numberOfImages - images.count, clearPrevious: false)
    }
    
    private func loadImages(query: String, numberOfImages: Int, clearPrevious: Bool) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            updateStateWithError(message: "Search query cannot be empty", clearImages: true)
            return
        }
        
        guard let url = createURL(query: query, numberOfImages: numberOfImages) else {
            updateStateWithError(message: "Invalid URL", clearImages: true)
            return
        }
        
        do {
            let imageResult = try await fetchImages(from: url)
            DispatchQueue.main.async {
                if clearPrevious {
                    self.images.removeAll()
                }
                self.errorMessage = nil
                self.noResults = imageResult.hits.isEmpty
                self.images.append(contentsOf: imageResult.hits)
            }
        } catch {
            updateStateWithError(message: error.localizedDescription, clearImages: false)
        }
    }
    
    private func createURL(query: String, numberOfImages: Int) -> URL? {
        let languageCode = detectLanguage(for: query)
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://pixabay.com/api/?key=\(apiKey)&q=\(encodedQuery)&image_type=photo&per_page=\(numberOfImages)&lang=\(languageCode)"
        return URL(string: urlString)
    }
    
    private func fetchImages(from url: URL) async throws -> ImageResult {
        let (data, _) = try await URLSession.shared.data(from: url, timeout: 20)
        return try JSONDecoder().decode(ImageResult.self, from: data)
    }
    
    private func updateStateWithError(message: String, clearImages: Bool) {
        DispatchQueue.main.async {
            self.errorMessage = message
            self.noResults = true
            if clearImages {
                self.images.removeAll()
            }
        }
    }
    
    private func detectLanguage(for text: String) -> String {
        let nsText = text as NSString
        let language = CFStringTokenizerCopyBestStringLanguage(nsText, CFRange(location: 0, length: nsText.length)) as String?
        return language == "ru" ? "ru" : "en"
    }
}

extension URLSession {
    func data(from url: URL, timeout: TimeInterval) async throws -> (Data, URLResponse) {
        let request = URLRequest(url: url, timeoutInterval: timeout)
        return try await data(for: request, delegate: nil)
    }
}
