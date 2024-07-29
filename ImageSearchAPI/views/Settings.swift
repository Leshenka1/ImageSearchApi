//
//  Settings.swift
//  ImageSearchAPI
//
//  Created by Алексей Зубель on 27.07.24.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var settings: ImageSearchSettings
    @State private var numberOfImagesString: String = ""
    @State private var numberOfColumnsString: String = ""

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                settingRow(
                    title: "Number of images:",
                    value: $settings.numberOfImages,
                    valueString: $numberOfImagesString,
                    range: 1...200
                )
                settingRow(
                    title: "Number of columns:",
                    value: $settings.numberOfColumns,
                    valueString: $numberOfColumnsString,
                    range: 1...5
                )
            }
        }
        .onAppear {
            numberOfImagesString = "\(settings.numberOfImages)"
            numberOfColumnsString = "\(settings.numberOfColumns)"
        }
    }

    private func settingRow(title: String, value: Binding<Int>, valueString: Binding<String>, range: ClosedRange<Int>) -> some View {
        HStack {
            Text(title)
            TextField("", text: valueString)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 50)
                .onChange(of: valueString.wrappedValue) { oldValue, newValue in
                    if let intValue = Int(newValue), range.contains(intValue) {
                        value.wrappedValue = intValue
                    } else {
                        valueString.wrappedValue = "\(value.wrappedValue)"
                    }
                }
            Spacer()
            Stepper(value: value, in: range) {
                Text("")
            }
            .labelsHidden()
            .onChange(of: value.wrappedValue) { oldValue, newValue in
                valueString.wrappedValue = "\(newValue)"
            }
        }
        .padding()
    }
}
