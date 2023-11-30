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
    
    //Tags...
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
    
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
            

            //send
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
        
    }
}

#Preview {
    ChipView()
}
