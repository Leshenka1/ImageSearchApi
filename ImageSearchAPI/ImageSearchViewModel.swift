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
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.errorMessage = "Search query cannot be empty"
            return
        }
        
        let languageCode = detectLanguage(for: query)
        
        guard let url = URL(string: "https://pixabay.com/api/?key=\(apiKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&image_type=photo&per_page=\(numberOfImages)&lang=\(languageCode)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url, timeout: 10)
            let imageResult = try JSONDecoder().decode(ImageResult.self, from: data)
            DispatchQueue.main.async {
                self.images = imageResult.hits
                self.noResults = imageResult.hits.isEmpty
                self.errorMessage = nil
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.noResults = false
            }
        }
    }
    
    private func detectLanguage(for text: String) -> String {
        let nsText = text as NSString
        let language = CFStringTokenizerCopyBestStringLanguage(nsText, CFRange(location: 0, length: nsText.length)) as String?
        switch language {
        case "ru":
            return "ru"
        default:
            return "en"
        }
    }
}

extension URLSession {
    func data(from url: URL, timeout: TimeInterval) async throws -> (Data, URLResponse) {
        let request = URLRequest(url: url, timeoutInterval: timeout)
        return try await data(for: request, delegate: nil)
    }
}
