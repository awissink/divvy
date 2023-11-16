//
//  DivvyApp.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

//@main
struct DivvyApp: App {
    init() {
            FirebaseApp.configure() // Initialize Firebase
        }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
