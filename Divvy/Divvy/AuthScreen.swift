//
//  AuthScreen.swift
//  Divvy
//
//  Created by Grace Perrin on 11/10/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to Divvy!")
                .font(.largeTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Enter phone number", text: $phoneNumber)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Verify Phone Number") {
                PhoneVerificationViewModel().verifyPhoneNumber(phoneNumber)
            }
            .padding()

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
        }
    }
}


#Preview {
    AuthView()
}

