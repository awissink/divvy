//
//  HomePage.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

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
//                newReceiptsView()
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
            
            //TO DO: add Logo here
            
            //            .navigationBarTitle(Text("Div/vy"), displayMode: .inline)
            //
            
        }
        .background(Color.white) // Set the background color of the NavigationView
        .onAppear {
            listenForReceipts()
        }
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

func listenForReceipts() {
    let currentUserID = Auth.auth().currentUser?.email
    guard let userID = currentUserID else { return }
    
    let db = Firestore.firestore()
    let claimedRef = db.collection("recipients").document(currentUserID!).collection("claimed")
    
    claimedRef.addSnapshotListener {
        querySnapshot, error in
        guard let documents = querySnapshot?.documents else {
            print("Error fetching documents: \(String(describing: error))")
            return
        }
        
        // processing received receipts
        for document in documents {
            let data = document.data()
            print("DATA IS: ", data)
            // make receipt objects from data and display/process them in the app
            let createdDate = data["createdDate"] as? String ?? ""
            let currencyCode = data["currencyCode"] as? String ?? ""
            let id = data["id"] as? Int ?? 0
            let imgFileName = data["imgFileName"] as? String ?? ""
            let imgThumbnailURL = data["imgThumbnailURL"] as? String ?? ""
            let imgURL = data["imgURL"] as? String ?? ""
            let lineItems = data["lineItems"] as? [LineItem] ?? []
            let ocrText = data["ocrText"] as? String ?? ""
            let subtotal = data["subtotal"] as? Double ?? 0.0
            let tax = data["tax"] as? Double ?? 0.0
            print("TAX IS: ", tax)
            let tip = data["tip"] as? Double ?? 0.0
            print("TIP IS: ", tip)
            let total = data["total"] as? Double ?? 0.0
            let vendor = data["vendor"] as? Vendor ?? nil
            print("VENDOR DATA: ", vendor)
            
            let receivedReceipt = Receipt(
                createdDate: createdDate,
                currencyCode: currencyCode,
                id: id,
                imgFileName: imgFileName,
                imgThumbnailURL: imgThumbnailURL,
                imgURL: imgURL,
                lineItems: lineItems,
                ocrText: ocrText,
                subtotal: subtotal,
                tax: tax,
                tip: tip,
                total: total,
                vendor: vendor!
        )}
    }
}


#Preview {
    HomePage()
}
