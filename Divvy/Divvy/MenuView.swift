//
//  MenuView.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import SwiftUI
import VeryfiSDK

struct MenuView: View {
    @StateObject var viewRouter: ViewRouter
    @StateObject var viewModel = ViewModel()
    @State private var isEditing = false
    @State private var isDataLoaded = false
    
    var body: some View {
        VStack {
            if isDataLoaded {
                HStack {
                    Button(action: {
                                    viewRouter.navigateTo(.home) // Navigate to the desired page
                                }) {
                                    HStack {
                                        Image(systemName: "Chevron.left") // Back button icon
                                            .foregroundColor(.secondary)
                                            
                                        Text("Back")
                                            .foregroundColor(.secondary)// Text for the back button
                                    }
                                }
                                .padding()
                    Spacer()
                    Text(viewModel.restaurantName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                    .foregroundColor(.white)
                    .frame(width: 80, height: 40)
                    .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                    .cornerRadius(28)
                    .font(.system(size:18, weight:.semibold))
                }
                List($viewModel.menuItems) { $item in
                    MenuItemView(menuItem: $item, isEditing: isEditing)
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
                    
                    NavigationLink(destination: ChipView(viewModel: viewModel)) {
                        Text("Share")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                            .cornerRadius(28)
                            .font(.system(size:18, weight:.semibold))

                    }

                }
            } else {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear {
                        viewModel.loadData { success in
                            if success {
                                isDataLoaded = true
                            }
                        }
                    }
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

