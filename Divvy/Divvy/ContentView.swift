//
//  ContentView.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI
import VeryfiSDK

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(viewModel.restaurantName)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
            List($viewModel.menuItems) { $item in
                            MenuItemView(menuItem: $item, isEditing: isEditing)
            }
            .onAppear() {
                viewModel.loadData()
            }
            Group {
                EditableTextValue(title: "Tax", value: $viewModel.tax, isEditing: isEditing)
                EditableTextValue(title: "Tip", value: $viewModel.tip, isEditing: isEditing)
                EditableTextValue(title: "Total", value: $viewModel.total, isEditing: isEditing)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Spacer()
                Button("Share") {
                }
                .padding()
            }
        }
        .padding()
    }
}

struct EditableTextValue: View {
    var title: String
    @Binding var value: Double
    var isEditing: Bool

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isEditing {
                TextField("", value: $value, format: .number)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(minWidth: 50, alignment: .trailing)
            } else {
                Text("\(value, specifier: "%.2f")")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
