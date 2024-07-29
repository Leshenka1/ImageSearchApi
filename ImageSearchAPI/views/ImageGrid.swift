//
//  ImageGrid.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

struct ImageGrid: View {
    let images: [ImageHit]
    @EnvironmentObject var settings: ImageSearchSettings

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: .zero), count: settings.numberOfColumns)
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: .zero) {
                ForEach(images) { imageHit in
                    ImageCell(imageHit: imageHit)
                        .background(.white)
                        .cornerRadius(8)
                        .clipped()
                        .padding(3)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}
