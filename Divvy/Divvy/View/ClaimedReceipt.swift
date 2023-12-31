//
//  ClaimedReceipt.swift
//  Divvy
//
//  Created by Hannah Grace and Amelia on 11/30/23.
//

import Foundation
import SwiftUI

struct ClaimedReceiptItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
    
}

struct ClaimedReceipt: View {
    
    let expense: Expense
    @State private var restaurantName: String
    @State private var receiptItems: [ClaimedReceiptItem]
        
    @Environment(\.presentationMode) var presentationMode
    
    init(expense: Expense) {
        self.expense = expense

        // Temporary variable for restaurant name
        let tempRestaurantName = expense.receipt.vendor.name

        // Temporary array for receipt items
        var tempReceiptItems: [ClaimedReceiptItem] = []

        for item in expense.receipt.lineItems {
            let newItem = ClaimedReceiptItem(name: item.description, price: item.total, quantity: item.quantity)
            tempReceiptItems.append(newItem)
        }

        // Initializing @State properties
        _restaurantName = State(initialValue: tempRestaurantName)
        _receiptItems = State(initialValue: tempReceiptItems)
    }
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                HStack {
                    Image(systemName: "fork.knife")
                        .foregroundColor(.primary)
                    
                    Text(restaurantName)
                        .font(.title)
                        .fontWeight(.medium)
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets()) // Remove separator for the first row
                
                
                List {
                    ForEach($receiptItems) { $item in
                        ItemView(receiptItem: $item)
                    }
                    .listRowInsets(EdgeInsets()) // Remove separator for each item
                }
                
                
                
                
                // Assuming ChipView is your share view, add it here
            }
            .padding()
            
            .navigationBarItems(leading: (
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss current view
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.secondary)
                            .imageScale(.large)
                        Text("Back")
                            .foregroundColor(.secondary)
                    }
                }
            ))
            .navigationViewStyle(StackNavigationViewStyle()) // Use StackNavigationViewStyle for full-screen back swipe gesture
            
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true) // Hide default back button
        
    }
}

struct ItemView: View {
    @Binding var receiptItem: ClaimedReceiptItem
    
    var body: some View {
        VStack {
            HStack {
                Text(receiptItem.name)
                    .font(.subheadline)
                
                Spacer()
                
                HStack(spacing: 8){
                    Text("\(receiptItem.price, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                    
                }
            }
            .padding(16)
            .padding(.trailing, 0)
        }
        .frame (maxWidth: .infinity, alignment: .leading)
    }
}


//#Preview {
//    ClaimItemsView()
//}
