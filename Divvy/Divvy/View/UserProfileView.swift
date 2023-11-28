//
//  UserProfileView.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/21/23.
//  user interface and design - joyce 11/24

import SwiftUI
import Firebase
import FirebaseAuth

struct UserProfileView: View {
    @EnvironmentObject var userData: UserData
    //@State private var email: String
    
    var email: String {
            userData.currentUserEmail
        }
    
    @State private var showingSignIn = false

    var body: some View {
        HStack{
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .padding()
        }
        VStack {
            VStack(spacing: 20) {
                // Profile picture or avatar placeholder
                Image(systemName: "person.circle.fill") // Using a system icon as a placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100) // Set desired size for the profile picture
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                Text("Jane Doe")
                    .font(.title)
                
                // Email display
                HStack{
                    Text("Email:")
                        .fontWeight(.semibold)
                    Spacer().frame(width: 8)
                    HStack {
                        Text(email)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
            }
            .padding()
            
            
            NavigationLink(destination: SignInView(), isActive: $showingSignIn) {
                EmptyView()
            }
            .hidden()
            // Logout button
            Button("Log Out") {
                do {
                    try Auth.auth().signOut()
                    userData.loggedIn = false
                    showingSignIn = true
                } catch let signOutError as NSError {
                    print("Error signing out: \(signOutError.localizedDescription)")
                }
            }
            .foregroundColor(.black)
            .frame(width: 284, height: 52)
            .cornerRadius(28)
            .padding()
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
//        .background(Color(UIColor.systemGroupedBackground)) // Matches the sign-up background
//        .edgesIgnoringSafeArea(.all)
        //                .background(Color(UIColor.systemGroupedBackground)) // Matches the sign-up background
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    UserProfileView()
//}
