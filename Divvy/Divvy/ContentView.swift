//
//  ContentView.swift
//  Divvy
//
//  Created by Test Account on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData

    var body: some View {
        ZStack {
            if userData.loggedIn {
                HomePage()
            } else {
                SignInView()
            }
        }
    }
}
