//
//  ReceiptView.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/23/23.
//  need to add dropdown - joyce 11/24

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
    @State private var restaurantName: String = "Restaurant name"
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
                .background(Color.green)
                .cornerRadius(28)
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
    }
}

// Renamed MenuItemView to ReceiptItemView
struct ReceiptItemView: View {
    @Binding var receiptItem: ReceiptItem
    var isEditing: Bool
    
//    var body: some View {
//        // Define your receipt item view
//        Text("\(receiptItem.name) - \(receiptItem.total, specifier: "%.2f")")
//    }
    
    var body: some View {
        VStack {
            HStack {
                Text(receiptItem.name)
                    .font(.headline)
                
                Spacer()
                
                Text("\(receiptItem.total, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
            customDropdownView()
                .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
        }
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

struct customDropdownView: View {

    let drop: [DropItem] = [
        DropItem(title: "joyce"),
        DropItem(title: "izzy"),
        DropItem(title: "grace"),
        DropItem(title: "eki"),
        DropItem(title: "amelia"),
        DropItem(title: "hannah")
        // Add more items as needed
    ]
    
    @State var show = false
    @State var name = "who had this item?"

    
    var body: some View {
        
        VStack {
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                    ScrollView{
                        VStack(spacing: 17){
                            ForEach (drop) { item in
                                Button {
                                    withAnimation {
                                        name = item.title
                                        show.toggle()
                                    }
                                } label: { //list of names
                                    Text(item.title).foregroundColor(.black)
                                        .bold()
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame (maxWidth: .infinity,alignment: .leading)
                        .padding(.vertical,15)
                    }
                }
                .frame (height: show ? 205 : 0)
                .offset(y: show ? 190 : -25)
                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                
                
                //who had item for dropdown
                ZStack{
                    RoundedRectangle(cornerRadius: 5).frame(height: 40)
                        .foregroundColor(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2) // Apply slight gray shadow
                    HStack{
                        Text(name).font(.subheadline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .rotationEffect(.degrees(show ? -90 : 0))
                            .font(.system(size: 12))
                    }
                    
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }
                
                .offset(y: -25)
                .onTapGesture {
                    withAnimation{
                        show .toggle()
                    }
                }
            }
        }
        .padding()
        
    }
}

#Preview {
    ReceiptView()
}
