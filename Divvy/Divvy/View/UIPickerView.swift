//
//  UIPickerView.swift
//  Divvy
//
//  Created by joyce jiang on 11/25/23.
//

import Foundation
import SwiftUI

struct UIPickerView: View {
    @State private var selectedOption1 = 0
    @State private var selectedOption2 = 0
    // Add more state variables for additional pickers if needed

    let options1 = ["Option 1A", "Option 1B", "Option 1C"]
    let options2 = ["Option 2A", "Option 2B", "Option 2C"]
    // Define options for additional pickers if needed

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Picker 1")) {
                    Picker("Picker 1", selection: $selectedOption1) {
                        ForEach(0 ..< options1.count) {
                            Text(self.options1[$0]).tag($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }

                Section(header: Text("Picker 2")) {
                    Picker("Picker 2", selection: $selectedOption2) {
                        ForEach(0 ..< options2.count) {
                            Text(self.options2[$0]).tag($0)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }

                // Add more Sections for additional pickers if needed
            }
            .navigationBarTitle("Multiple Pickers")
        }
    }
}

#Preview{
    UIPickerView()
}
