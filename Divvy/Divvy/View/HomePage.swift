//
//  HomePage.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//

import SwiftUI

struct HomePage: View {
    // Computed property to construct the header
        var headerView: some View {
            Group {
                Text("Overall, you owe ")
                    .foregroundColor(.black)
                + Text("$258.66")
                    .foregroundColor(.fireyOrange)
            }
            .font(.headline) // Apply font to the entire Group
        }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: headerView) {
                    ForEach(BalanceData) { balance in
                        HStack {
                            Circle()
                                .fill(balance.color)
                                .frame(width: 30, height: 30)
                                .overlay(Text(balance.initials)
                                            .foregroundColor(.white))
                            Text(balance.name)
                                .foregroundColor(.black)
                            Spacer()
                            Text(balance.amount)
                                .foregroundColor(balance.amount.contains("owes") ? .fireyOrange : balance.color)
                        }
                    }
                }
                // ... Rest of your code, updating colors as necessary
                Section(header: Text("Unclaimed Expenses")
                    .foregroundColor(.black)
                    .font(.headline)
                    .textCase(nil)) {
                        ForEach(ExpenseData) { expense in
                            NavigationLink(destination: ReceiptView()) { // This is the link to the ReceiptView
                                HStack {
                                    Image(systemName: expense.icon)
                                        .foregroundColor(.gray)
                                    Text(expense.description)
                                        .foregroundColor(.black)
//                                    Spacer()
//                                    Button(action: {
//                                        
//                                    }) {
//                                        Text("Claim")
//                                            .foregroundColor(.forestGreen)
//                                    }
//                                    .tint(.mintGreen)
//                                    .buttonStyle(.borderedProminent)
//                                    .buttonBorderShape(.roundedRectangle(radius: 8))
                                }
                            }
                        }
                    }
                
                
                Section(header: Text("Previously Settled Expenses")
                    .foregroundColor(.black)
                    .font(.headline)
                    .textCase(nil)) {
                        NavigationLink(destination: ReceiptView()) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Receipt from Oct 30, 11:58pm")
                                    .foregroundColor(.black)
                                Spacer()
                                Text("paid!")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                
                
                
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle to have a clear background
            .background(Color.white) // Set the background color of the List
            .navigationBarTitle(Text("Div/vy"), displayMode: .inline)
        }
        .background(Color.white) // Set the background color of the NavigationView
    }
}

struct Balance: Identifiable {
    let id = UUID()
    let name: String
    let amount: String
    let color: Color
    let initials: String
}

struct Expense: Identifiable {
    let id = UUID()
    let description: String
    let icon: String
}

let BalanceData = [
    Balance(name: "Andrew Yan", amount: "owes you $3.63", color: .babyBlue, initials: "AY"),
    Balance(name: "Angela Mu", amount: "settled up", color: .mintGreen, initials: "AM"),
    Balance(name: "Veer Chauhan", amount: "you owe $262.29", color: .forestGreen, initials: "VC")
]

let ExpenseData = [
    Expense(description: "Receipt from Nov 1, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 2, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 3, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 4, 10:02am", icon: "doc.text")
]

// Your preview code...


#Preview {
    HomePage()
}
