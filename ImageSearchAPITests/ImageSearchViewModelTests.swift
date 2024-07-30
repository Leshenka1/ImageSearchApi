//
//  ImageSearchViewModelTests.swift
//  ImageSearchAPITests
//
//  Created by Алексей Зубель on 29.07.24.
//

import XCTest
@testable import ImageSearchAPI

final class ImageSearchViewModelTests: XCTestCase {
    var viewModel: ImageSearchViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ImageSearchViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testSearchImagesWithValidQuery() {
        let query = "cats"
        let numberOfImages = 10
        
        let expectation = self.expectation(description: "Searching images")
        
        Task {
            await viewModel.searchImages(query: query, numberOfImages: numberOfImages)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }

            XCTAssertFalse(self.viewModel.images.isEmpty, "Images should not be empty")
            XCTAssertFalse(self.viewModel.noResults, "No results flag should be false")
            XCTAssertNil(self.viewModel.errorMessage, "Error message should be nil")
        }
    }
    
    func testSearchImagesWithEmptyQuery() {
        let query = ""
        let numberOfImages = 10
        
        let expectation = self.expectation(description: "Searching images")
        
        Task {
            await viewModel.searchImages(query: query, numberOfImages: numberOfImages)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }

            // Используем отдельные ожидания для проверки обновления свойств
            DispatchQueue.main.async {
                XCTAssertTrue(self.viewModel.images.isEmpty, "Images should be empty")
                XCTAssertTrue(self.viewModel.noResults, "No results flag should be true")
                XCTAssertEqual(self.viewModel.errorMessage, "Search query cannot be empty", "Error message should indicate empty query")
            }
        }
    }
}
