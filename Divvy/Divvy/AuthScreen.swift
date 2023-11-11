//
//  AuthScreen.swift
//  Divvy
//
//  Created by Grace Perrin on 11/10/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

struct AuthView: View {
    
    @State private var phoneNumber: String = ""
    
    var body: some View {
    
        //VStack for all of the elements on the signup page
        VStack {
            
            //Placeholder image for the swipe stack animation example
            Image(.exampleStack)
            
            Spacer().frame(height:30)
            
            //Logo and tag line
            Image(.logo)
            Text("the new way to split the bill")
                .font(.system(size:26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer().frame(height: 30)
            
            //Text field and its description
            Text("enter your number")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .font(.system(size:16, weight:.medium))
                .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
            Spacer().frame(height: 5)
            TextField("", text: $phoneNumber)
                .frame(width: 326, height: 40)
                .background(Color(red: 0xE0 / 240.0, green: 0xE0 / 240.0, blue: 0xE0 / 240.0))
                .cornerRadius(10)
                .textFieldStyle(PlainTextFieldStyle())
            
            Spacer().frame(height: 10)
            
            //Enter button which will send verification code
            //Will also link with firebase to create a new account (TBI)
            Button(action: {
                print("sign up button tapped")
            }) {
                Text("enter")
                    .foregroundColor(.white)
                    .padding(.leading, 100)
                    .padding(.trailing, 100)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .background(Color(red: 0x3E / 255.0, green: 0x88 / 255.0, blue: 0x5B / 255.0))
                    .cornerRadius(20)
                    .font(.system(size:18, weight:.semibold))
            }
            .padding()
            
            //For users that already have an account, allows them to sign in instead of signing up
            Button(action: {
                //do action to bring them to a sign in page instead of the sign up page
                print("sign in button tapped")
            }) {
                Text("already a user? login here")
                    .offset(y: -10)
                    .font(.system(size:16, weight:.medium))
                    .foregroundColor(Color(red: 0xE0 / 330.0, green: 0xE0 / 330.0, blue: 0xE0 / 330.0))
                    .underline()
            }
            
            
//            Button("Verify Phone Number") {
//                PhoneVerificationViewModel().verifyPhoneNumber(phoneNumber)
//
//            }

            if let errorMessage = PhoneVerificationViewModel().errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            if let verificationID = PhoneVerificationViewModel().verificationID {
                // You can use the verificationID here or navigate to another screen
                // based on your application logic.
                Text("Verification ID: \(verificationID)")
            }
        }
        //add padding and offset to align elements and push the whole VStack up on the screen
            .offset(y: -50)
            .padding()

        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}


class PhoneVerificationViewModel: ObservableObject {
    @Published var verificationID: String?
    @Published var errorMessage: String?

    func verifyPhoneNumber(_ phoneNumber: String) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            self.verificationID = verificationID
            
            print(verificationID!)
        }
    }
}


#Preview {
    AuthView()
}

