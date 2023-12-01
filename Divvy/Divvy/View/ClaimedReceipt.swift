//
//  claimItemsView.swift
//  Divvy
//
//  Created by joyce jiang on 11/30/23.
//

import Foundation
import SwiftUI

struct UnclaimedReceiptItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
    
}

struct ClaimedReceipt: View {
    
    let expense: Expense
    @State private var restaurantName: String
    @State private var receiptItems: [UnclaimedReceiptItem]
        
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    init(expense: Expense) {
        self.expense = expense

        // Temporary variable for restaurant name
        let tempRestaurantName = expense.receipt.vendor.name

        // Temporary array for receipt items
        var tempReceiptItems: [UnclaimedReceiptItem] = []

        for item in expense.receipt.lineItems {
            let newItem = UnclaimedReceiptItem(name: item.description, price: item.total, quantity: item.quantity)
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
                HStack{
                    
                }
                .padding(.bottom, 16)
                
                
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




//#Preview {
//    ClaimItemsView()
//}
