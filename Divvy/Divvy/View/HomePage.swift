//
//  HomePage.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//

import SwiftUI

struct HomePage: View {
    // Computed property to construct the header
    
    //11.24 jo: removing overall you owe, and adding the three cards do the swipe
    
    var headerView: some View {
//        Text("Card view here")
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                ForEach(ExpenseData) { expense in
                    GeometryReader { geometry in
                        
                        //background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(
                                    degrees: Double((geometry.frame(in: .global).minX - 20) / -20)
                                ),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .center,
                                anchorZ: 0.0,
                                perspective: 1.0
                            )
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        //                            .strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1)
                        
                        //content
                        
                        NavigationLink(destination: ReceiptView()) {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                
                                Image(systemName: expense.icon)
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.gray)
                                
                                
                                Spacer()
                                Text("Restaurant")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                Text(expense.description)
                                    .font(.system(size: 16))
                            }
                            .padding(32)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                        }
                        
                    }
                    .frame(width: 280, height: 300)
                }
            }
            .padding()
//            .navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
        }
    }
    
    var body: some View {
        //logo
        HStack{
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .padding()
        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
        NavigationView {
            
            List {
//                newReceiptsView()
                Section(header: headerView) {
                    //                    ForEach(BalanceData) { balance in
                    //                        HStack {
                    //                            Circle()
                    //                                .fill(balance.color)
                    //                                .frame(width: 30, height: 30)
                    //                                .overlay(Text(balance.initials)
                    //                                            .foregroundColor(.white))
                    //                            Text(balance.name)
                    //                                .foregroundColor(.black)
                    //                            Spacer()
                    //                            Text(balance.amount)
                    //                                .foregroundColor(balance.amount.contains("owes") ? .fireyOrange : balance.color)
                    //                        }
                    //                    }
                }
                // ... Rest of your code, updating colors as necessary
                
                
                //joyce 11/25 6:15am
                
                
                //                Section(header: Text("✨ NEW RECEIPTS") //unclained receipts
                //                    .foregroundColor(Color(red: 0.51, green: 0.51, blue: 0.51))
                //                    .font(.headline)
                //                    .textCase(nil))
                //                {
                //                    ScrollView(.horizontal, showsIndicators: false) {
                //                        HStack(spacing: 15) { // Adjust the spacing as needed
                //                            ForEach(ExpenseData) { expense in
                //                                NavigationLink(destination: ReceiptView()) {
                //                                    VStack(alignment: .leading, spacing: 4) {
                //                                        Image(systemName: expense.icon)
                //                                            .foregroundColor(.gray)
                //                                        Spacer()
                //                                        Text("Restaurant")
                //                                            .foregroundColor(.black)
                //                                        //                                                Text(expense.description)
                //                                        //                                                    .foregroundColor(.black)
                //                                        Text(expense.description)
                //                                            .font(Font.custom("SF Pro Display", size: 12))
                //                                            .foregroundColor(Color(red: 0.05, green: 0.09, blue: 0.13))
                //                                            .multilineTextAlignment(.leading)
                //
                //                                    }
                //
                //                                }
                //                                .padding(10)
                //                                .frame(width: 130, height: 138)
                //                                .overlay(
                //                                    RoundedRectangle(cornerRadius: 10)
                //                                        .strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1)
                //                                )
                //                            }
                //                        }
                //                    }
                //                    .frame(height: 160) // Set the fixed height of the ScrollView/Section
                //                }
                ///
                
//                Section(header: Text("Unclaimed Expenses")
//                    .foregroundColor(.black)
//                    .font(.headline)
//                    .textCase(nil)) {
//                        ForEach(ExpenseData) { expense in
//                            NavigationLink(destination: ReceiptView()) { // This is the link to the ReceiptView
//                                HStack {
//                                    Image(systemName: expense.icon)
//                                        .foregroundColor(.gray)
//                                    Text(expense.description)
//                                        .foregroundColor(.black)
//                                    Spacer()
//                                    //                                    Button(action: {
//                                    //
//                                    //                                    }) {
//                                    //                                        Text("Claim")
//                                    //                                            .foregroundColor(.forestGreen)
//                                    //                                    }
//                                    //                                    .tint(.mintGreen)
//                                    //                                    .buttonStyle(.borderedProminent)
//                                    //                                    .buttonBorderShape(.roundedRectangle(radius: 8))
//                                }
//                            }
//                        }
//                    }
//
                
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
            
            //TO DO: add Logo here
            
            //            .navigationBarTitle(Text("Div/vy"), displayMode: .inline)
            //
            
        }
        .background(Color.white)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
        // Set the background color of the NavigationView
    }
}

struct newReceiptsView: View {
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16) {
                ForEach(ExpenseData) { expense in
                    GeometryReader { geometry in
                        
                        //background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(
                                    degrees: Double((geometry.frame(in: .global).minX - 20) / -20)
                                ),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .center,
                                anchorZ: 0.0,
                                perspective: 1.0
                            )
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        //                            .strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1)
                        
                        //content
                        
                        NavigationLink(destination: ReceiptView()) {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                
                                Image(systemName: expense.icon)
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.gray)
                                
                                
                                Spacer()
                                Text("Restaurant")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                Text(expense.description)
                                    .font(.system(size: 16))
                            }
                            .padding(32)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                        }
                        
                    }
                    .frame(width: 280, height: 300)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
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

//let BalanceData = [
//    Balance(name: "Andrew Yan", amount: "owes you $3.63", color: .babyBlue, initials: "AY"),
//    Balance(name: "Angela Mu", amount: "settled up", color: .mintGreen, initials: "AM"),
//    Balance(name: "Veer Chauhan", amount: "you owe $262.29", color: .forestGreen, initials: "VC")
//]

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
