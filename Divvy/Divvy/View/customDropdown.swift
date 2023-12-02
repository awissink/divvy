//
//  customDropdown.swift
//  Divvy
//
//  Created by joyce jiang on 11/24/23.
//

import Foundation
import SwiftUI

struct DropItem: Identifiable {
    let id = UUID()
    let title: String
}
    
struct customDropdownView2: View {

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
                //dropdown
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
                                } label: {
                                    Text(item.title).foregroundColor(.black)

                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame (maxWidth: .infinity,alignment: .leading)
                        .padding(.vertical,15)
                    }
                }
                .frame (height: show ? 205 : 50)
                .offset(y: show ? 0 : -145)
                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                
                
                //who had item
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(height: 60)
                        .foregroundColor(Color.white)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 0, y: 2) // Apply slight gray shadow
                    HStack{
                        Text(name).font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .rotationEffect(.degrees(show ? -90 : 0))
                    }
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }

                .offset(y: -145)
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

struct customDropdownView_Previews: PreviewProvider {
    static var previews: some View {
        customDropdownView2()
    }
}
