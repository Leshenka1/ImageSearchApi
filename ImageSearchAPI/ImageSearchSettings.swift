//
//  ImageSearchSettings.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 27.07.24.
//

import SwiftUI

class ImageSearchSettings: ObservableObject {
    @Published var numberOfImages: Int = 10
    @Published var numberOfColumns: Int = 2
}
