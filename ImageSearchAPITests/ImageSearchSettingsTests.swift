//
//  ImageSearchSettingsTests.swift
//  ImageSearchAPITests
//
//  Created by Алексей Зубель on 29.07.24.
//

import XCTest
@testable import ImageSearchAPI

final class ImageSearchSettingsTests: XCTestCase {
    var settings: ImageSearchSettings!

    override func setUp() {
        super.setUp()
        settings = ImageSearchSettings()
    }

    override func tearDown() {
        settings = nil
        super.tearDown()
    }

    func testDefaultSettings() {
        XCTAssertEqual(settings.numberOfImages, 10, "Default number of images should be 10")
        XCTAssertEqual(settings.numberOfColumns, 2, "Default number of columns should be 2")
    }

    func testUpdateSettings() {
        settings.numberOfImages = 20
        settings.numberOfColumns = 3

        XCTAssertEqual(settings.numberOfImages, 20, "Number of images should be 20")
        XCTAssertEqual(settings.numberOfColumns, 3, "Number of columns should be 3")
    }
}
