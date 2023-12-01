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
                    .autocapitalization(.none)
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
                SecureField("", text: $userPassword)
                    .autocapitalization(.none)
                    .accessibilityLabel("Password")
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
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    
                }
                .frame(width: 182, height: 204.3)
                .offset(x: 40)
                .rotationEffect(.degrees(10))
                
                //left card
                ZStack() {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                        .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
                    Image(systemName: "doc.text")
                        .resizable()
                        .frame(width: 20, height: 24)
                        .foregroundColor(.gray)
                    Spacer()
                    
                }
                .frame(width: 182, height: 204.3)
                .offset(x: -40, y: -10)
                .rotationEffect(.degrees(-16))
                
                //center card
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9512709975, green: 1, blue: 0.930760324, alpha: 1)), Color(#colorLiteral(red: 0.7515366077, green: 0.8420163989, blue: 0.7321715951, alpha: 1))]), startPoint: .center, endPoint: .bottomTrailing))
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 2)
                    //content
                    VStack(alignment: .leading, spacing: 4){
                        Image(systemName: "doc.text")
                            .resizable()
                            .frame(width: 20, height: 24)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Thai Diner")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                        Text("Nov 16, 2023")
                            .font(.system(size: 14))
                    }
                    .padding(24)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .offset(x: -24)
                }
                .frame(width: 188, height: 210)
                
            }
            
        }
    }
}


#Preview{
    SwipeStack()
}
