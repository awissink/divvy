//
//  ContentView.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Create User") {
                FirebaseAuthManager.createUser(email: "example@example.com", password: "password123") { uid, error in
                    if let error = error {
                        print("Error creating user:", error.localizedDescription)
                    } else if let uid = uid {
                        print("User created:", uid)
                        // Perform actions after user creation (e.g., navigating to another view)
                    }
                }
            }
            
            Button("Sign In") {
                FirebaseAuthManager.signIn(email: "example@example.com", password: "password123") { uid, error in
                    if let error = error {
                        print("Error signing in:", error.localizedDescription)
                    } else if let uid = uid {
                        print("User signed in:", uid)
                        // Perform actions after sign-in (e.g., navigate to the main screen)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
