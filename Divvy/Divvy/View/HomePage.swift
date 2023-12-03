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
    
    func listenForUnclaimedReceipts() async {
        let currentUserID = Auth.auth().currentUser?.email
        let db = Firestore.firestore()
        let unclaimedRef = db.collection("recipients").document(currentUserID!).collection("unclaimed")

        do {
            let querySnapshot = try await unclaimedRef.getDocuments()
            DispatchQueue.main.async {
                self.receivedReceipts.removeAll()
                for document in querySnapshot.documents {
                    let data = document.data()
                    if let receipt = try? JSONDecoder().decode(Receipt.self, from: JSONSerialization.data(withJSONObject: data)) {
                        self.receivedReceipts.append(receipt)
                    }
                }
                // Trigger UI update
                updateExpenseData()
            }
        } catch {
            print("Error fetching documents: \(error)")

                
            }
    }
    
    
    func listenForClaimedReceipts() async {
        let currentUserID = Auth.auth().currentUser?.email
        let claimedRef = Firestore.firestore().collection("recipients").document(currentUserID!).collection("claimed")

        do {
            let querySnapshot = try await claimedRef.getDocuments()
            DispatchQueue.main.async {
                self.claimedReceipts.removeAll()
                for document in querySnapshot.documents {
                    let data = document.data()
                    if let receipt = try? JSONDecoder().decode(Receipt.self, from: JSONSerialization.data(withJSONObject: data)) {
                        self.claimedReceipts.append(receipt)
                    }
                }
                // Trigger UI update
                updateClaimedExpenseData()
            }
        } catch {
            print("Error fetching documents: \(error)")
        }
    }
    
    var swipeCardView: some View {
        //        Text("Card view here")
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
                if expenseData.isEmpty {
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
            .refreshable {
                // Call functions to fetch new data
                await refreshData()
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle to have a clear background
            .background(Color.white) // Set the background color of the List
            
        }
        .background(Color.white) // Set the background color of the NavigationView
        .onAppear {
            fetchData()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    private func refreshData() async {

                // Reload data
                await listenForUnclaimedReceipts()
                await listenForClaimedReceipts()
                
                // Since these functions are asynchronous,
                // you may need to wait for them to complete
                // or use other ways to ensure the data is fully loaded.
            }
        
    private func updateExpenseData() {
            expenseData = receivedReceipts.map { receipt in
                Expense(description: receipt.createdDate ?? "", icon: "doc.text", receipt: receipt)
            }
        }

    private func updateClaimedExpenseData() {
        claimedExpenseData = claimedReceipts.map { receipt in
            Expense(description: receipt.createdDate ?? "", icon: "doc.text", receipt: receipt)
        }
    }

// Add this function to handle async calls
    private func fetchData() {
        Task {
            await listenForUnclaimedReceipts()
            await listenForClaimedReceipts()
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
    let receipt: Receipt
}
