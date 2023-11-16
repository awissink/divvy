//
//  FirebaseAuthManager.swift
//  Divvy
//
//  Created by Test Account on 11/14/23.
//

import Firebase
import FirebaseAuth

struct FirebaseAuthManager {
    static func createUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let uid = authResult?.user.uid {
                    completion(uid, nil)
                } else {
                    completion(nil, NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                }
            }
        }
    }

    static func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let uid = authResult?.user.uid {
                    completion(uid, nil)
                } else {
                    completion(nil, NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                }
            }
        }
    }
}
