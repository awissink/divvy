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
    @State private var receivedReceipts: [Receipt] = []
    @State private var expenseData: [Expense] = []
    @State private var doneListening: Bool = false
    
    func listenForReceipts() {
        let currentUserID = Auth.auth().currentUser?.email
        
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
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let receipt = try JSONDecoder().decode(Receipt.self, from: jsonData)
                    
                    receivedReceipts.append(receipt)
                    print("RECEIVED RECEIPT LIST: ", receivedReceipts)
                    
                    // Handle the receipt object
                } catch {
                    print("Error decoding: \(error.localizedDescription)")
                }
                
            }
            doneListening = true
        }
    }
    
    var swipeCardView: some View {
        //        Text("Card view here")
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:-5){
                ForEach(ExpenseData) { expense in
                    GeometryReader { geometry in
                        //background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                            .rotation3DEffect(
                                Angle(
                                    degrees: Double((geometry.frame(in: .global).minX - 15) / -20)
                                ),
                                axis: (x: 0, y: 1, z: 0),
                                anchor: .center,
                                anchorZ: 0.0,
                                perspective: 1.0
                            )
                            .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        
                        //content
                        NavigationLink(destination: ClaimItemsView()) {
                            VStack(alignment: .leading, spacing: 4) {
                                Image(systemName: expense.icon)
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Restaurant name")
                                    .font(.system(size: 24))
                                    .fontWeight(.medium)
                                Text(expense.description)
                                    .font(.system(size: 16))
                            }
                            .padding(24)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                        }
                        
                    }
                    .frame(width: 220, height: 280)
                }
                .padding()
            }
        }
    }
    
    var body: some View {
        //logo
        NavigationView {
            
            List {
                HStack {
                    Spacer()
                    Image(.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                        .padding()
                    Spacer()
                }
                
                Section(header: swipeCardView) {
                }
                
                Section(header: Text("Previously settled expenses")
                    .foregroundColor(.black)
                    .font(.headline)
                    .textCase(nil)) {
                        NavigationLink(destination: ClaimItemsView()) {
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
        .background(Color.white) // Set the background color of the NavigationView
        .onAppear {
            listenForReceipts()
        }
        .onChange(of: doneListening) { newDataLoaded in
            if newDataLoaded {
                print("RECEIVED RECEIPTS VARIABLE CONTAINS: ", receivedReceipts)
                //populate expenseData array
                for receipt in receivedReceipts {
                    print("DOING A RECEIPT: ", receipt.vendor.name)
                    let expense = Expense(description: (receipt.vendor.name + " " + (receipt.createdDate ?? receipt.createdDate!)), icon: "doc.text")
                    expenseData.append(expense)
                }
            }
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


#Preview {
    HomePage()
}
