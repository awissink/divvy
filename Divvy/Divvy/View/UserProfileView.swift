//
//  UserProfileView.swift
//  Divvy
//
//  Created by Eki Uzamere on 11/21/23.
//

import SwiftUI

struct UserProfileView: View {
    @State private var email: String = "user@example.com" // Replace with actual data binding

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                // Profile picture or avatar placeholder
                Text("Hello Again!")
                    .font(.title)
                    .italic()
                
                Image(systemName: "person.circle.fill") // Using a system icon as a placeholder
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100) // Set desired size for the profile picture
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .padding(.top, 50) // Adjust the padding as needed

                // Email display
                HStack {
                    Text("Email:")
                        .fontWeight(.semibold)
                    Text(email)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 1)
            }
            .padding()

            // Logout button
            Button("Log Out") {
                // Handle logout action here
            }
            .foregroundColor(.white)
            .frame(width: 200) // Set the width to a fixed size
            .padding()
            .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
            .cornerRadius(10)
            .font(.system(size: 18, weight: .semibold))
            .padding(.bottom, 50) // Adjust the padding as needed
        }
//        .background(Color(UIColor.systemGroupedBackground)) // Matches the sign-up background
//        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    UserProfileView()
}
