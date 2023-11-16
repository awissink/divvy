//
//  SignInView.swift
//  Divvy
//
//  Created by Grace Perrin on 11/16/23.
//

import SwiftUI

struct SignInView: View {
    
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    var body: some View {
        NavigationStack {
            //VStack for all the elements on the signup page
            VStack {
                
                //Placeholder image for the swipe stack animation
                Image(.exampleStack)
                
                Spacer().frame(height:30)
                
                //Logo and tag line
                Image(.logo)
                Text("the new way to split the bill")
                    .font(.system(size:26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer().frame(height: 30)
                
                //email field
                Text("enter your email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 35)
                    .font(.system(size:16, weight:.medium))
                    .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                Spacer().frame(height: 5)
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
                Spacer().frame(height: 5)
                TextField("", text: $userPassword)
                    .padding(.leading, 10) //add padding so the cursor is not on the very edge
                    .frame(width: 326, height: 40)
                    .background(Color(red: 0xE0 / 240.0, green: 0xE0 / 240.0, blue: 0xE0 / 240.0))
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Button("Sign In") {
                    FirebaseAuthManager.signIn(email: userEmail, password: userPassword) { uid, error in
                        if let error = error {
                            print("Error signing in:", error.localizedDescription)
                        } else if let uid = uid {
                            print("User signed in:", uid)
                            // Perform actions after sign-in (e.g., navigate to the main screen)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 100)
                .padding(.trailing, 100)
                .padding(.top, 15)
                .padding(.bottom, 15)
                .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                .cornerRadius(20)
                .font(.system(size:18, weight:.semibold))
                
                NavigationLink(destination: ContentView()) {
                    Text("don't have an account? sign up here")
                        .font(.system(size:16, weight:.medium))
                        .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                        .underline()
                }
                
            }
        }
    }
}

#Preview {
    SignInView()
}
