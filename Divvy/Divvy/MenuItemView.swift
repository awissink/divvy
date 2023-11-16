//
//  MenuItemView.swift
//  Divvy
//
//  Created by Amelia Wissink on 11/16/23.
//

import SwiftUI

struct MenuItemView: View {
    var menuItem: LineItem
    
    var body: some View {
        HStack {
            Text(menuItem.description)
            Spacer()
            Text(String(menuItem.total))
        }
        .padding()
    }
}

#Preview {
    MenuItemView(menuItem: LineItem(description: "Eggs Benedict", id: 1, order: 0, price: 13.50, quantity: 1, total: 13.50))
}
