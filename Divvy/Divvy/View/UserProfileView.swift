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
//                Image(systemName: "person.circle.fill") // Using a system icon as a placeholder
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 100, height: 100) // Set desired size for the profile picture
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
//                
//                // Email display
//                
//                    HStack {
//                        Text(email)
//                    }
//                    .frame (maxWidth: .infinity,alignment: .leading)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 1)
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)),
                                                       Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    VStack(spacing: 10) {
                        HStack {
                            Image("EMVChip")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                            
                            Spacer(minLength: 0)
                            
                            Image("CardLogo")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                        }
                        
                        HStack(spacing: 12) {
                            Text("MM/YY")
                            Spacer(minLength: 0)
                            Text("CVV")
                                .frame(width: 35)
                        }
                        .padding(.top,15)
                        Spacer(minLength: 0)
                        Text(email)
                            .font(.title3)
                        
                    }
                    .padding(20)
                    .environment(\.colorScheme, .dark)
                    .tint(.white)
                }
                .frame(height: 200)
                .padding(.top, 35)
                
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
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .cornerRadius(28) // Apply corner radius directly to the button
            .padding()

            Spacer()
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview{
    UserProfileView()
}
