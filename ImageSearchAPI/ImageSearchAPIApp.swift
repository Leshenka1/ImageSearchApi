//
//  ImageSearchAPIApp.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 25.07.24.
//

import SwiftUI

@main
struct ImageSearchAPIApp: App {
    @StateObject private var settings = ImageSearchSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
