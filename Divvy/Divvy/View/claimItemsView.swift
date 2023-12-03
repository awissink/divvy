//
//  claimItemsView.swift
//  Divvy
//
//  Created by joyce jiang on 11/30/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ReceiptItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let quantity: Int
    
    var isChecked = false //added isChecked property for the total amt
    var total: Double {
        return price * Double(quantity)
    }
}

struct ClaimItemsView: View {
    
    let expense: Expense
    @State private var restaurantName: String
    @State private var receiptItems: [ReceiptItem]
    @State private var total: Double = 0.0
    @State private var isEditing = false
    @State private var isChecked = false
        
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    init(expense: Expense) {
        self.expense = expense

        // Temporary variable for restaurant name
        let tempRestaurantName = expense.receipt.vendor.name

        // Temporary array for receipt items
        var tempReceiptItems: [ReceiptItem] = []

        for item in expense.receipt.lineItems {
            let newItem = ReceiptItem(name: item.description, price: item.total, quantity: item.quantity, isChecked: false)
            tempReceiptItems.append(newItem)
        }

        // Initializing @State properties
        _restaurantName = State(initialValue: tempRestaurantName)
        _receiptItems = State(initialValue: tempReceiptItems)
    }

    private func recalculateTotal() {
        total = receiptItems.reduce(0) { $0 + ($1.isChecked ? $1.total : 0) }
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
                        ClaimItemCheckmarkView(receiptItem: $item, recalculateTotal: recalculateTotal)
                    }
                    .listRowInsets(EdgeInsets()) // Remove separator for each item
                }

                
                Group {
                    ReceiptEditableValue(title: "Your total", value: $total, isEditing: isEditing)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                
                //send invitations
                Button(action: {
                    //TO-DO: NEED TO ROUTE BACK TO HOMEPAGE
                    
                    //TO-DO: MOVE DOCUMENT TO "CLAIMED" COLLECTION
                    let db = Firestore.firestore()
                    let currentUserID = Auth.auth().currentUser?.email
                    let unclaimedRef = db.collection("recipients").document(currentUserID!).collection("unclaimed")
                    
                    let claimedRef = db.collection("recipients").document(currentUserID!).collection("claimed")
                    claimedRef.document(restaurantName).setData(convertToDictionary(receipt: expense.receipt)!) { error in
                           if let error = error {
                               print("Error sending receipt: \(error)")
                           } else {
                               print("Receipt sent successfully to \(restaurantName)")
                           }
                       }
                    
                    //delete the receipt from unclaimed collect
                    unclaimedRef.document(restaurantName).delete { error in
                        if let error = error {
                            print("Error deleting document: \(error)")
                        } else {
                            print("Document deleted successfully")
                        }
                    }
                    
                    // Handle button tap
                    //"https://venmo.com/?txn=pay&note=" + $restaurantName + "&amount=" + $total
                    if let encodedRestaurantName = restaurantName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                           let venmoDeeplink = URL(string: "https://venmo.com/?txn=pay&note=" + encodedRestaurantName + "&amount=" + String(total)) {
                                            openURL(venmoDeeplink)
                                        }
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

struct ClaimItemCheckmarkView: View {
    @Binding var receiptItem: ReceiptItem
    var recalculateTotal: () -> Void // Closure to recalculate total
    
    var body: some View {
        VStack {
            HStack {
                Text(receiptItem.name)
                    .font(.subheadline)
                
                Spacer()
                
                HStack(spacing: 8){
                    Text("\(receiptItem.total, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        receiptItem.isChecked.toggle() // Toggle isChecked property of ReceiptItem
                        recalculateTotal() // Recalculate total when the item is toggled
                    }) {
                        Image(systemName: receiptItem.isChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(receiptItem.isChecked ? Color("ForestGreen") : .gray)
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


//#Preview {
//    ClaimItemsView()
//}
