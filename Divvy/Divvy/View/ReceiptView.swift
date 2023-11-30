//
//  ReceiptView.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/23/23.
//  need to add dropdown - joyce 11/24

import SwiftUI
import HalfASheet

//DEPRACATED -> Using claimItemsView instead

//// Renamed LineItem model to ReceiptItem for convenience
//struct ReceiptItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let price: Double
//    let quantity: Int
//    
//    var isChecked = false //added isChecked property for the total amt
//    var total: Double {
//        return price * Double(quantity)
//    }
//}


// Updated ReceiptView with the ViewModel's functionality
struct ReceiptView: View {
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
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(restaurantName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                    }
                    .foregroundColor(.white)
                    .frame(width: 80, height: 40)
                    .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                    .cornerRadius(28)
                    .font(.system(size:15, weight:.semibold))
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
struct ReceiptItemView: View {
    @Binding var receiptItem: ReceiptItem
    var isEditing: Bool
    @State private var showDropdown = true // Use a local state for the dropdown
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(receiptItem.name)
                    .font(.subheadline)
                
                Spacer()
                
                Text("\(receiptItem.total, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
            Spacer()
            pickerView()
        }
        .frame (maxWidth: .infinity,alignment: .leading)
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

struct pickerView: View {
    // Define your data source for the Picker
    let options = ["joyce", "izzy", "amelia", "grace", "eki", "hannah"]
    
    // State variables
    @State private var selectedOption = ""
    @State private var isPickerVisible = false
    @State private var settingsDetent = PresentationDetent.medium
    
    var body: some View {
        VStack {
            // Display selected option or placeholder text
            VStack{
                Text(selectedOption.isEmpty ? "who had this item?" : selectedOption)
                    .foregroundColor(selectedOption.isEmpty ? Color(UIColor.systemGray3) : Color.black)
                    .frame (maxWidth: .infinity,alignment: .leading)
                    .padding(5)
                    .font(.subheadline)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.systemGray5), lineWidth: 1) // Add border
                            .frame(height: 30)
                    )
            }
            .onTapGesture {
                self.isPickerVisible = true
            }
            
            Spacer()
                .sheet(isPresented: $isPickerVisible) {
                    ScrollView {
                        Spacer()
                        VStack(alignment: .leading) {
                            ForEach(options, id: \.self) { option in
                                HStack {
                                    Text(option)
                                        .onTapGesture {
                                            self.selectedOption = option // Update selectedOption
                                            self.isPickerVisible = false
                                        }
                                    Spacer()
                                    if selectedOption == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.selectedOption = option // Update selectedOption
                                    self.isPickerVisible = false
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .presentationDetents(
                        [.medium, .large],
                        selection: $settingsDetent
                    )
                    
                }
        }
    }
}


#Preview {
    ReceiptView()
}
