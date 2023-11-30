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
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        NavigationStack {
            //VStack for all the elements on the signup page
            VStack {
                
                SwipeStack() //Created structure for swipe stack animation -joyce 11/26
                Spacer().frame(height: 40)
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
                TextField("", text: $userPassword)
                    .padding(.leading, 10) //add padding so the cursor is not on the very edge
                    .frame(width: 326, height: 40)
                    .background(Color(red: 0xE0 / 240.0, green: 0xE0 / 240.0, blue: 0xE0 / 240.0))
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                let firebaseAuthManager = FirebaseAuthManager(userData: userData)
                
                Spacer().frame(height: 24)
                
                Button("Sign in") {
                    firebaseAuthManager.signIn(email: userEmail, password: userPassword) { uid, error in
                        if let error = error {
                            print("Error signing in:", error.localizedDescription)
                        } else if let uid = uid {
                            print("User signed in:", uid)
                            //re route to the homescreen after account validation
                            userData.loggedIn = true
                            userData.currentUserEmail = userEmail
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
                
                NavigationLink(destination: SignUpView()) {
                    Text("don't have an account? sign up here")
                        .offset(y: 5)
                        .font(.system(size:14, weight:.medium))
                        .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                        .underline()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//#Preview {
//    SignInView()
//}

struct SwipeStack: View{
    var body: some View{
        ZStack {
            //cards
            ZStack() {
                //right card
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 182, height: 204.3)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9.32)
                                .inset(by: -0.93)
                                .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.93)
                        )
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 7.46, y: 3.73
                        )
                        .rotationEffect(.degrees(20))
                }
                .frame(width: 182, height: 204.3)
                .offset(x: 40)
                .rotationEffect(.degrees(-4))
                
                
                //left card
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 182, height: 204.3)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: -0.93)
                                .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.93)
                        )
                        .offset(x: 0, y: 0)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 7.46, y: 3.73
                        )
                    Text("September")
                        .font(.system(size: 18))
                        .offset(x: -32, y: -80)
                    Spacer()

                }
                .frame(width: 182, height: 204.3)
                .offset(x: -40, y: -10)
                .rotationEffect(.degrees(-16))
                
                //center card
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 182, height: 204.3)
                        .background(.white)
                        .cornerRadius(9.32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9.32)
                                .inset(by: -0.93)
                                .stroke(Color(red: 0.95, green: 0.95, blue: 0.95), lineWidth: 0.93)
                        )
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.06), radius: 7.46, y: 3.73
                        )
                }
            }
            VStack(alignment: .leading){
                Text("November 8")
                    .font(.system(size: 18))
                Text("✨ New divvy")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.92, green: 0.34, blue: 0.34))
                Spacer()
                //users?
                HStack(alignment: .top, spacing: -18.64) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .background(Color(red: 255/255, green: 232/255, blue: 165/255))
                            .cornerRadius(45)
                        Text("JJ")
                            .foregroundColor(.secondary)
                    }
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .background(Color(red: 223/255, green: 215/255, blue: 251/255))
                            .cornerRadius(45)
                        Text("IL")
                            .foregroundColor(.secondary)
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 40, height: 40)
                            .background(Color(red: 201/255, green: 236/255, blue: 253/255))
                            .cornerRadius(45)
                        Text("AW")
                            .foregroundColor(.secondary)
                    }
                    

                }
                
                Text("OBAO")
                    .font(.system(size: 22))
            }
            .frame(height: 180)
            .offset(x: -24)
        }
    }
}

