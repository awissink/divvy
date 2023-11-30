//
//  Home.swift
//  Divvy
//
//  Created by Eki Uzamere on 10/29/23.
//

import SwiftUI

struct ChipView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text: String = ""
    
    @StateObject var viewRouter = ViewRouter()
    @EnvironmentObject var userData: UserData
    @State private var sentReceipt = false
    
    //Tags...
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
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
            
            
            //old send button
//            Button(action: {
//                   // Handle button tap
//           }) {
//               Text("Send invitations")
//                   .foregroundColor(.black)
//                   .frame(width: 284, height: 52)
//           }
//           .background(Color(red: 0.95, green: 0.95, blue: 0.95))
//           .cornerRadius(28)
//           .padding()
            
//            NavigationLink(destination: SignUpView()) {
//                Text("don't have an account? sign up here")
//                    .offset(y: 5)
//                    .font(.system(size:14, weight:.medium))
//                    .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
//                    .underline()
//            }
            
            //new send receipt button
            Button {
                do {
                    userData.loggedIn = false
                    sentReceipt = true
                    
                    //show popup alert
                    showAlert.toggle()
                    alertMessage = "Receipts successfully sent!"
                    
                    
                    
                } catch let signOutError as NSError {
                    print("Error sending receipts: \(signOutError.localizedDescription)")
                }
            } label: {
                Text("Send Invitations")
                    .frame(width: 284, height: 52)
                    .foregroundColor(.black)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(28)
                    .padding()
            }
            .hidden()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("ok")))
            }
            
            
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
//
//#Preview {
//    ChipView()
//}
