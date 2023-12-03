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
    @State private var claimedReceipts: [Receipt] = []
    @State private var expenseData: [Expense] = []
    @State private var claimedExpenseData: [Expense] = []
    @State private var doneListening: Bool = false
    @State private var doneClaimedListening: Bool = false
    
    func listenForUnclaimedReceipts() {
        let currentUserID = Auth.auth().currentUser?.email
        
        let db = Firestore.firestore()
        let unclaimedRef = db.collection("recipients").document(currentUserID!).collection("unclaimed")
        
        unclaimedRef.addSnapshotListener {
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
                    
                    // Handle the receipt object
                } catch {
                    print("Error decoding: \(error.localizedDescription)")
                }
                
            }
            doneListening = true
        }
    }
    
    func listenForClaimedReceipts() {
        let currentUserID = Auth.auth().currentUser?.email
        
        let db = Firestore.firestore()
        let ClaimedRef = db.collection("recipients").document(currentUserID!).collection("claimed")
        
        ClaimedRef.addSnapshotListener {
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
                    
                    claimedReceipts.append(receipt)
                    print("RECEIVED RECEIPT LIST: ", claimedReceipts)
                    
                    // Handle the receipt object
                } catch {
                    print("Error decoding: \(error.localizedDescription)")
                }
                
            }
            doneClaimedListening = true
        }
    }
    
    var swipeCardView: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing:-5){
                ForEach(expenseData) { expense in
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
                        NavigationLink(destination: ClaimItemsView(expense: expense)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Image(systemName: expense.icon)
                                    .resizable()
                                    .frame(width: 20, height: 24)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(expense.receipt.vendor.name)
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
                
                // if no new divvys, show EmptyDivvy struct
                if expenseData.isEmpty && doneListening && doneClaimedListening {
                    HStack{
                        Spacer()
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
                            
                            VStack {
                                
                                Text("No new Divvys")
                                    .font(.system(size: 24))
                                    .foregroundColor(.secondary)
                                
                            }
                            .padding(24)
                            .padding(.top, 100)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .frame (maxWidth: .infinity, alignment: .center)
                        }
                        .frame(width: 220, height: 280)
                        Spacer()
                    }
                    
                    
                    
                } else {
                    Section(header: swipeCardView) {
                    }
                }
                
                
                Section(header: Text("Claimed Divvys")
                    .foregroundColor(.black)
                    .font(.headline)
                    .textCase(nil)) {
                        ForEach(claimedExpenseData) { expense in
                            GeometryReader { geometry in
                                NavigationLink(destination: ClaimedReceipt(expense: expense)) {
                                    VStack{
                                        Spacer() //ADDED THIS
                                        HStack {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                                            let createdDate = String(expense.receipt.createdDate!.prefix(10)) ?? ""
                                            let restaurantName = expense.receipt.vendor.name ?? ""
                                            let receiptField = restaurantName + ", " + createdDate
                                            Text(receiptField)
                                                .foregroundColor(.black)
                                            Spacer()
                                            Text("paid!")
                                                .foregroundColor(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                                        }
                                        Spacer() //ADDED THIS
                                    }
                                }
                            }
                        }
                    }
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle to have a clear background
            .background(Color.white) // Set the background color of the List
            
        }
        .background(Color.white) // Set the background color of the NavigationView
        .onAppear {
            listenForUnclaimedReceipts()
            listenForClaimedReceipts()
        }
        .onChange(of: doneListening) { newDataLoaded in
            if newDataLoaded {
                //populate expenseData array
                for receipt in receivedReceipts {
                    let expense = Expense(description: receipt.createdDate ?? receipt.createdDate!, icon: "doc.text",
                                          receipt: receipt)
                    expenseData.append(expense)
                }
            }
        }
        .onChange(of: doneClaimedListening) { newDataLoaded in
            if newDataLoaded {
                //populate expenseData array
                for receipt in claimedReceipts {
                    let expense = Expense(description: receipt.createdDate ?? receipt.createdDate!, icon: "doc.text",
                                          receipt: receipt)
                    claimedExpenseData.append(expense)
                    
                    print("CLAIMED EXPENSE DATA: ", claimedExpenseData)
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
    let receipt: Receipt
}
