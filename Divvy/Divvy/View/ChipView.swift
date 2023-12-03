//
//  Home.swift
//  Divvy
//
//  Created by Eki Uzamere on 10/29/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ChipView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text: String = ""
    @State var enteredEmails: [String] = []
    
    @StateObject var viewRouter = ViewRouter()
    @EnvironmentObject var userData: UserData
    @State private var sentReceipt = false
    
    //Tags...
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
    @State var showSentReceiptAlert: Bool = false
    @State var alertMessage: String = ""
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.secondary)
                        Text("Back")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                Spacer()
            }
            
            HStack {
                Text("Send out invites")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.black) //different from tutorial
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            HStack {
                // Custom Tag View ...
                TagView(maxLimit: 150, tags: $tags)
                // Default Height
                    .frame(height: 280)
                    .padding(.top, 20)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            HStack{
                
                // TextField ...
                TextField("Who's in the Divvy?", text: $text)
                    .font(.title3)
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.secondary, lineWidth: 1)
                    )
                // Setting only Textfield as Dark...
                    .environment(\.colorScheme, .light)
                    .padding(.vertical, 20)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)

            
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
            
            //send receipt button
            NavigationLink(destination: NavBar(viewRouter: viewRouter), isActive: $sentReceipt) {
                EmptyView()
            }
            .hidden()
            Button {
                //show popup alert
//                showSentReceiptAlert.toggle()
                //set to true and reroute
                let someReceipt = viewModel.currReceipt
                print("someReceipt is currently: ", someReceipt as Any)
                for email in enteredEmails{
                    sendReceipt(to: email, receipt: convertToDictionary(receipt: someReceipt!), restaurantName: viewModel.restaurantName)
                }
                sentReceipt = true
            } label: {
                Text("Send Invitations")
                    .frame(width: 284, height: 52)
                    .foregroundColor(.black)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(28)
                    .padding()
            }
//            .alert(isPresented: $showSentReceiptAlert) {
//                Alert(title: Text("Alert"), message: Text("Receipts successfully sent!"), dismissButton: .default(Text("ok")))
//            }
            
            
        }
        .padding(15)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)),
                    Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))
                ]),
                startPoint: .center,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Tag Limit Exceeded - try to delete some tags !!!"), dismissButton: .destructive(Text("Ok")))
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

//send and listen TO-DO: move listen for receipt func to homescreen later

func sendReceipt(to recipientID: String, receipt: [String: Any]?, restaurantName: String) {
    let db = Firestore.firestore()
    let unclaimedRef = db.collection("recipients").document(recipientID).collection("unclaimed")
    unclaimedRef.document(restaurantName).setData(receipt!) { error in
            if let error = error {
                print("Error sending receipt: \(error)")
            } else {
                print("Receipt sent successfully to \(restaurantName)")
            }
        }
}

func convertToDictionary(receipt: Receipt) -> [String: Any]? {
    do {
        let data = try JSONEncoder().encode(receipt)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary
    } catch {
        print("Error converting to dictionary: \(error)")
        return nil
    }
}


//#Preview {
//    ChipView()
//}
