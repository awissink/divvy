//
//  MenuItemView.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/22/23.
//

import SwiftUI

struct MenuItemView: View {
    @Binding var menuItem: LineItem
    var isEditing: Bool
    
    var body: some View {
        HStack {
            Text(menuItem.description)
            Spacer()
            if isEditing {
                TextField("", value: $menuItem.total, format: .number)
                                    .textFieldStyle(PlainTextFieldStyle()) // Makes it look like plain text
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(minWidth: 50, alignment: .trailing)
            } else {
                Text("\(menuItem.total, specifier: "%.2f")")
            }
        }
        .padding()
    }
}
