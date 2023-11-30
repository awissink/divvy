//
//  claimItemsView.swift
//  Divvy
//
//  Created by joyce jiang on 11/30/23.
//

import Foundation
import SwiftUI


struct ClaimItemsView: View {
    @State private var restaurantName: String = "Restaurant name"
    @State private var receiptItems: [ReceiptItem] = [
        ReceiptItem(name: "Burger", price: 9.99, quantity: 1),
        ReceiptItem(name: "Fries", price: 4.99, quantity: 2),
        ReceiptItem(name: "Soda", price: 1.99, quantity: 1)
    ]
    @State private var total: Double = 0.0
    @State private var isEditing = false
    
    @Environment(\.presentationMode) var presentationMode // Access to presentation mode
    
    
    // Function to recalculate the total
    private func recalculateTotal() {
        total = receiptItems.reduce(0) { $0 + $1.total }
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
                    Text("start claiming your items!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 16)
                
                List {
                    
                    
                    ForEach($receiptItems) { $item in
                        ClaimItemCheckmarkView(receiptItem: $item)
                    }
                    .listRowInsets(EdgeInsets()) // Remove separator for each item
                }
                
                
                Group {
                    ReceiptEditableValue(title: "Total", value: $total, isEditing: isEditing)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                
                //send invitations
                Button(action: {
                    // Handle button tap
                }) {
                    Text("Confirm")
                        .foregroundColor(.black)
                        .frame(width: 284, height: 52)
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(28)
                .padding()
                
                // Assuming ChipView is your share view, add it here
            }
            .padding()
            .onAppear {
                recalculateTotal()
            }
            
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

// Renamed MenuItemView to ReceiptItemView
struct ClaimItemCheckmarkView: View {
    @Binding var receiptItem: ReceiptItem
    
    @State private var isChecked = false
    
    var body: some View {
        VStack {
            
            HStack {
                Text(receiptItem.name)
                    .font(.subheadline)
                
                Spacer()
                
                //pricing
                HStack(spacing: 8){
                    Text("\(receiptItem.total, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                    
                    //checkbox
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(isChecked ? .green : .gray)
                            .font(.system(size: 20))
                    }
                }
            }
            .padding(16)
            .padding(.trailing, 0)
            
        }
        .frame (maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    ClaimItemsView()
}
