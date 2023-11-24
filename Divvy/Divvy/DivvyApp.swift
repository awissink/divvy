//
//  DivvyApp.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI
import Firebase
import FirebaseAuth


@main
struct DivvyApp: App {
    
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
        @StateObject var viewRouter = ViewRouter()
    }
    
    var body: some Scene {

        WindowGroup {
            ContentView().environmentObject(UserData())
            
        }
    }
}


class UserData: ObservableObject {
   @Published var loggedIn = false
}
