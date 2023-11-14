//
//  individualClaimStacks.swift
//  testingFlow
//
//  Created by joyce jiang on 11/13/23.
//

import Foundation
import SwiftUI

struct individualClaims: View {
    
    
    var body: some View{
        
        //Members of a party
        HStack(spacing: 8) {
            //Member 1
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                    AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(23.10)
                .overlay(
                    RoundedRectangle(cornerRadius: 23.10)
                        .inset(by: 1)
                        .stroke(Color(red: 0.18, green: 0.62, blue: 0.86), lineWidth: 1)
                    //stroke to show current member is selected
                )
                .shadow(
                    color: Color(red: 0.18, green: 0.50, blue: 0.93, opacity: 0.15), radius: 21, y: 4
                )
            //Member 2
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                    AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(23.10)
            //Member 3
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                    AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(96.25)
            //Member 4
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 46.20, height: 46.20)
                .background(
                    AsyncImage(url: URL(string: "https://via.placeholder.com/46x46"))
                )
                .cornerRadius(96.25)
        }
        .frame(width: 208.80, height: 46.20)
        
        
        //restaurant name
        
        VStack(alignment: .leading) {
            Text("Restaurant name")
                .font(Font.system(size: 32))
                .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                .multilineTextAlignment(.leading)
            Text("Date")
                .font(Font.system(size: 22))
                .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                .multilineTextAlignment(.leading)
        }
        
        //list of entrees
        
        List {
            ForEach(menuItems, id: \.self) { menuItem in
                HStack {
                    Text(menuItem.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("$\(menuItem.formattedPrice)")
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
            }
        }
        
        //send invitations
        Button(action: {
               // Handle button tap
           }) {
               Text("Send invitations")
                   .foregroundColor(.black)
                   .frame(width: 284, height: 52)
           }
           .background(Color(red: 0.95, green: 0.95, blue: 0.95))
           .cornerRadius(28)
           .padding()
        
    }
}

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var price: Double
    
    var formattedPrice: String {
        return String(format: "%.2f", price)
    }
}


let menuItems = [
    MenuItem(name: "Pasta", price: 12.99),
    MenuItem(name: "Salad", price: 8.99),
    MenuItem(name: "Steak", price: 19.99),
    // Add more menu items as needed
]

#Preview{
    individualClaims()
}
