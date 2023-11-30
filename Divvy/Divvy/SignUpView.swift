//
//  SignUpView.swift
//  Divvy
//
//  Created by Grace Perrin on 11/22/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
            //VStack for all the elements on the signup page
            VStack {
                
                SwipeStack()
                
                Spacer().frame(height:40)
                
                //Logo and tag line
                Image(.logo)
                    .resizable() // Make the image resizable
                    .frame(width: 105, height: 37)
                Text("the new way to split the bill")
                    .font(.system(size:18))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer().frame(height: 48)
                
                //email field
                Text("enter your email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 35)
                    .font(.system(size:16, weight:.medium))
                    .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                
                Spacer().frame(height: 8)
                
                TextField("", text: $userEmail)
                    .padding(.leading, 10) //add padding so the cursor is not on the very edge
                    .frame(width: 326, height: 40)
                    .background(Color(red: 0xE0 / 240.0, green: 0xE0 / 240.0, blue: 0xE0 / 240.0))
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                //password filed
                Text("enter your password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 35)
                    .font(.system(size:16, weight:.medium))
                    .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                Spacer().frame(height: 8)
                //how come if changed to SecureField to hide the password it doesn't let the user login?
                TextField("", text: $userPassword)
                    .padding(.leading, 10) //add padding so the cursor is not on the very edge
                    .frame(width: 326, height: 40)
                    .background(Color(red: 0xE0 / 240.0, green: 0xE0 / 240.0, blue: 0xE0 / 240.0))
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                let firebaseAuthManager = FirebaseAuthManager(userData: userData)
                
                Spacer().frame(height: 24)
                
                Button("Create account") {
                    print("trying to create a user")
                    firebaseAuthManager.createUser(email: userEmail, password: userPassword) { uid, error in
                        if let error = error {
                            print("Error creating user:", error.localizedDescription)
                        } else if let uid = uid {
                            print("User created:", uid)
                            
                            print("userData value" + String(userData.loggedIn))
                            print("setting userData to logged in true")
                            userData.loggedIn = true
                            userData.currentUserEmail = userEmail
                            print("userData value" + String(userData.loggedIn))
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 100)
                .padding(.trailing, 100)
                .padding(.top, 15)
                .padding(.bottom, 15)
                .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                .cornerRadius(28)
                .font(.system(size:18, weight:.semibold))


            }
    }
}


//#Preview {
//    SignUpView()
//}
