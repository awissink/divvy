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
        NavigationView {
            
            List {
                
                Section(header: headerView) {
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
            
        }
        .background(Color.white)
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

let ExpenseData = [
    Expense(description: "Receipt from Nov 1, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 2, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 3, 10:02am", icon: "doc.text"),
    Expense(description: "Receipt from Nov 4, 10:02am", icon: "doc.text")
]

#Preview {
    HomePage()
}
