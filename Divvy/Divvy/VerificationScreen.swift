//
//  VerificationScreen.swift
//  Divvy
//
//  Created by Grace Perrin on 11/13/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct VerificationView: View {
    
    @Binding var verificationID: String?
    @State private var userVerificationInput: String=""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            // Implement the UI for entering the verification code here
            // You can use a TextField to get user input and handle the code verification logic
            TextField("Enter Verification Code", text: $userVerificationInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: verifyCode){
                Text("verify number")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Verification Code")
    }
    
    //Function to sign up a user
    func verifyCode() {
        //ensure verificationID = verificationID
        guard let verificationID = verificationID else {
            return
        }
        //get credential from user
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: userVerificationInput)
        //try to sign in with that credential
        Auth.auth().signIn(with: credential) { _, error in
            guard error == nil else {
                return
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(verificationID: .constant("123456"))
    }
}

#Preview {
    VerificationView(verificationID: .constant("123456"))
}
