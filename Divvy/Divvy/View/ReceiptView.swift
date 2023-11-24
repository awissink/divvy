//
//  ReceiptView.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/23/23.
//

import SwiftUI

// Renamed LineItem model to ReceiptItem for convenience
struct ReceiptItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
    var total: Double {
        return price * Double(quantity)
    }
}

// Updated ReceiptView with the ViewModel's functionality
struct ReceiptView: View {
    @State private var restaurantName: String = "Restaurant Name"
    @State private var receiptItems: [ReceiptItem] = [
        ReceiptItem(name: "Burger", price: 9.99, quantity: 1),
        ReceiptItem(name: "Fries", price: 4.99, quantity: 2),
        ReceiptItem(name: "Soda", price: 1.99, quantity: 1)
    ]
    @State private var total: Double = 0.0
    @State private var isEditing = false
    
    // Function to recalculate the total
    private func recalculateTotal() {
        total = receiptItems.reduce(0) { $0 + $1.total }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(restaurantName)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
                .foregroundColor(.white)
                .frame(width: 80, height: 40)
                .background(Color.green)
                .cornerRadius(10)
                .font(.system(size:18, weight:.semibold))
            }
            List {
                ForEach($receiptItems) { $item in
                    ReceiptItemView(receiptItem: $item, isEditing: isEditing)
                }
            }
            Group {
                ReceiptEditableValue(title: "Total", value: $total, isEditing: isEditing)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            // Assuming ChipView is your share view, add it here
        }
        .padding()
        .onAppear {
            recalculateTotal()
        }
    }
}

// Renamed MenuItemView to ReceiptItemView
struct ReceiptItemView: View {
    @Binding var receiptItem: ReceiptItem
    var isEditing: Bool
    
    var body: some View {
        // Define your receipt item view
        Text("\(receiptItem.name) - \(receiptItem.total, specifier: "%.2f")")
    }
}

// Renamed EditableTextValue to ReceiptEditableValue
struct ReceiptEditableValue: View {
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
    ReceiptView()
}
