//
//  FirebaseAuthManager.swift
//  Divvy
//
//  Created by Hannah Luo on 11/14/23.
//

import Firebase
import FirebaseAuth

class FirebaseAuthManager {
    
    private var userData: UserData

    init(userData: UserData) {
        self.userData = userData
    }
        
    func createUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            print("trying to create a new user")
            if let error = error {
                completion(nil, error)
            } else {
                if let uid = authResult?.user.uid {
                    completion(uid, nil)
                    self.handleAuthenticationSuccess()
                } else {
                    completion(nil, NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            print("trying to sign in a user")
            if let error = error {
                completion(nil, error)
            } else {
                if let uid = authResult?.user.uid {
                    completion(uid, nil)
                    self.handleAuthenticationSuccess()
                } else {
                    completion(nil, NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                }
            }
        }
    }
    
    private func handleAuthenticationSuccess() {
        self.userData.loggedIn = true
    }
    
}
