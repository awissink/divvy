//
//  MenuItemView.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/16/23.
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

//#Preview {
//    MenuItemView(menuItem: LineItem(description: "Eggs Benedict", id: 1, order: 0, price: 13.50, quantity: 1, total: 13.50), isEditing: false)
//}
