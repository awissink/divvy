//
//  Home.swift
//  Divvy
//
//  Created by Eki Uzamere on 10/29/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import SwiftUI
import FirebaseFirestore

struct ChipView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text: String = ""
    @State var enteredEmails: [String] = []
    
    //Tags...
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left") // Use a system image for back arrow
                            .foregroundColor(.secondary) // Set the color to white
                        Text("Back")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                Spacer()
            }
            
            Text("Send out invites")
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.black) //different from tutorial
                .frame(maxWidth: .infinity, alignment: .leading)
            // Custom Tag View ...
            TagView(maxLimit: 150, tags: $tags)
            // Default Height
                .frame(height: 280)
                .padding(.top, 20)
            
            // TextField ...
            TextField("Who's in the Divvy?", text: $text)
                .font(.title3)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.secondary, lineWidth: 1)
                )
            // Setting only Textfield as Dark...
                .environment(\.colorScheme, .light)
                .padding(.vertical, 20)
            
            // Add Button...
            Button {
                if !text.isEmpty {
                    enteredEmails.append(text)
                }
                // adding Tag...
                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 150) {
                    alert, tag in
                    if alert {
                        //Showing alert
                        showAlert.toggle()
                    } else {
                        tags.append(tag)
                        text = ""
                    }
                }
            } label: {
                Text("Add a guest")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal,45)
                    .background(Color(red: 0.26, green: 0.26, blue: 0.26))
                    .cornerRadius(28)
            }

            // Disabling Button...
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)
            
//            Button("Send") {
//                        
//            }
//                .fontWeight(.semibold)
//                .foregroundColor(Color("BG"))
//                .padding(.vertical, 12)
//                .padding(.horizontal,45)
//                .background(.white)
//                .cornerRadius(10)
            
            //send
            Button(action: {
                //getting the receipt
                let someReceipt = viewModel.currReceipt
                print("someReceipt is currently: ", someReceipt as Any)
                for email in enteredEmails{
                    sendReceipt(to: email, receipt: convertToDictionary(receipt: someReceipt!), restaurantName: viewModel.restaurantName)
                }
               }) {
                   Text("Send invitations")
                       .foregroundColor(.black)
                       .frame(width: 284, height: 52)
               }
               .background(Color(red: 0.95, green: 0.95, blue: 0.95))
               .cornerRadius(28)
               .padding()

            
        }
        .padding(15)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
        .background(
            Color(.white)
                .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Tag Limit Exceeded - try to delete some tags !!!"), dismissButton: .destructive(Text("Ok")))
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

//send and listen TO-DO: move listen for receipt func to homescreen later

func sendReceipt(to recipientID: String, receipt: [String: Any]?, restaurantName: String) {
    let db = Firestore.firestore()
    let claimedRef = db.collection("recipients").document(recipientID).collection("claimed")
    claimedRef.document(restaurantName).setData(receipt!) { error in
            if let error = error {
                print("Error sending receipt: \(error)")
            } else {
                print("Receipt sent successfully to \(restaurantName)")
            }
        }
}

func listenForReceipts(restaurantName: String) {
    let currentUserID = Auth.auth().currentUser?.email
    guard let userID = currentUserID else { return }
    
    let db = Firestore.firestore()
    db.collection("receipts").document(userID).collection("received").addSnapshotListener { querySnapshot, error in
        guard let documents = querySnapshot?.documents else {
            print("Error fetching documents: \(String(describing: error))")
            return
        }
        
        // processing received receipts
        for document in documents {
            let data = document.data()
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
            let tip = data["tip"] as? Double ?? 0.0
            let total = data["total"] as? Double ?? 0.0
            let vendor = data["vendor"] as? Vendor ?? nil
            
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
            )
        }
    }
}

func convertToDictionary(receipt: Receipt) -> [String: Any]? {
    do {
        let data = try JSONEncoder().encode(receipt)
        print("DATA IS: ", data)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        print("DICTIONARY IS: ", dictionary ?? "doesn't exist")
        return dictionary
    } catch {
        print("Error converting to dictionary: \(error)")
        return nil
    }
}


//#Preview {
//    ChipView()
//}
